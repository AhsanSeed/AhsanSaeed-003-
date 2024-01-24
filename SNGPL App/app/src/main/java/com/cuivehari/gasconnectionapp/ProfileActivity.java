package com.cuivehari.gasconnectionapp;

import static com.cuivehari.gasconnectionapp.utils.Constants.usersCollection;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Dialog;
import android.app.ProgressDialog;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import com.cuivehari.gasconnectionapp.databinding.ActivityNewConnectionBinding;
import com.cuivehari.gasconnectionapp.databinding.ActivityProfileBinding;
import com.cuivehari.gasconnectionapp.models.UserModel;
import com.cuivehari.gasconnectionapp.utils.CommonValidation;
import com.cuivehari.gasconnectionapp.utils.Dialogs;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.CollectionReference;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.storage.FirebaseStorage;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

public class ProfileActivity extends AppCompatActivity {

    UserModel userModel;
    CommonValidation commonValidation;
    private ProgressDialog progressDialog;
    private Dialog dialog;

    FirebaseAuth firebaseAuth;
    FirebaseFirestore firebaseFirestore;

    ActivityProfileBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityProfileBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        initWidgets();
    }

    private void initWidgets() {

        commonValidation = new CommonValidation();

        dialog = Dialogs.ProgressLoadingDialog(this);
        progressDialog = Dialogs.MessageProgressDialog(this, "Please Wait...");

        firebaseAuth = FirebaseAuth.getInstance();
        firebaseFirestore = FirebaseFirestore.getInstance();

        dialog.show();
        getUserData(firebaseAuth.getUid());

        TextWatcher textWatcher = new TextWatcher() {
            private String current = "";
            private final String ddmmyyyy = "DDMMYYYY";
            private final Calendar cal = Calendar.getInstance();

            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                if (!s.toString().equals(current)) {
                    String clean = s.toString().replaceAll("[^\\d.]|\\.", "");
                    String cleanC = current.replaceAll("[^\\d.]|\\.", "");

                    int cl = clean.length();
                    int sel = cl;
                    for (int i = 2; i <= cl && i < 6; i += 2) {
                        sel++;
                    }
                    //Fix for pressing delete next to a forward slash
                    if (clean.equals(cleanC)) sel--;

                    if (clean.length() < 8){
                        clean = clean + ddmmyyyy.substring(clean.length());
                    }else{
                        //This part makes sure that when we finish entering numbers
                        //the date is correct, fixing it otherwise
                        int day  = Integer.parseInt(clean.substring(0,2));
                        int mon  = Integer.parseInt(clean.substring(2,4));
                        int year = Integer.parseInt(clean.substring(4,8));

                        mon = mon < 1 ? 1 : Math.min(mon, 12);
                        cal.set(Calendar.MONTH, mon-1);
                        year = (year<1900)?1900: Math.min(year, 2100);
                        cal.set(Calendar.YEAR, year);
                        // ^ first set year for the line below to work correctly
                        //with leap years - otherwise, date e.g. 29/02/2012
                        //would be automatically corrected to 28/02/2012

                        day = Math.min(day, cal.getActualMaximum(Calendar.DATE));
                        clean = String.format(Locale.getDefault(), "%02d%02d%02d",day, mon, year);
                    }

                    clean = String.format("%s/%s/%s", clean.substring(0, 2),
                            clean.substring(2, 4),
                            clean.substring(4, 8));

                    sel = Math.max(sel, 0);
                    current = clean;
                    binding.edtCNICIssueDate.setText(current);
                    binding.edtCNICIssueDate.setSelection(Math.min(sel, current.length()));
                }
            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        };
        binding.edtCNICIssueDate.addTextChangedListener(textWatcher);

        binding.btnUpdateProfile.setOnClickListener(view -> updateProfile());
    }

    private void getUserData(String userID) {
        DocumentReference documentReference = firebaseFirestore.collection(usersCollection).document(userID);

        documentReference.get()
                .addOnSuccessListener(documentSnapshot -> {
                    if (documentSnapshot.exists()) {
                        UserModel model = documentSnapshot.toObject(UserModel.class);
                        if (model != null) {
                            userModel = model;
                            setTextFields();
                        }
                    }
                    else
                    {
                        Toast.makeText(getApplicationContext(), "User data does not exits..!", Toast.LENGTH_LONG).show();
                    }
                    dialog.dismiss();
                })
                .addOnFailureListener(e -> {
                    dialog.dismiss();
                    Toast.makeText(getApplicationContext(), "Error : " + e.getMessage(), Toast.LENGTH_LONG).show();
                });
    }

    private void setTextFields() {
        binding.edtUserName.setText(userModel.getUser_name());
        binding.edtEmail.setText(userModel.getEmail());
        binding.edtCNIC.setText(userModel.getCnic());
        binding.edtMobileNo.setText(userModel.getPhone());
        binding.edtCNICIssueDate.setText(userModel.getCnic_issue_date());
    }
    
    private void updateProfile() {
        if (commonValidation.checkEmpty(binding.edtUserName, "Username Required")
                && commonValidation.checkEmpty(binding.edtMobileNo, "Phone Number Required")
                && commonValidation.checkEmpty(binding.edtCNIC, "CNIC Required")
                && commonValidation.checkEmpty(binding.edtCNICIssueDate, "CNIC Issue Date Required")
                )
        {
            String username = getString(binding.edtUserName);
            String email = getString(binding.edtEmail);
            String phone = getString(binding.edtMobileNo);
            String cnic = getString(binding.edtCNIC);
            String cnicIssueDate = getString(binding.edtCNICIssueDate);

            userModel.setUser_name(username);
            userModel.setPhone(phone);
            userModel.setCnic(cnic);
            userModel.setCnic_issue_date(cnicIssueDate);

            progressDialog.show();
            updateDataInFirebase();
        }
    }

    private void updateDataInFirebase() {
        CollectionReference collectionReference = firebaseFirestore.collection(usersCollection);
        DocumentReference docReference = collectionReference.document(userModel.getUser_auth_id());

        // Create a map with the fields you want to update
        Map<String, Object> updates = new HashMap<>();
        updates.put("user_name", userModel.getUser_name());
        updates.put("phone", userModel.getPhone());
        updates.put("cnic", userModel.getCnic());
        updates.put("cnic_issue_date", userModel.getCnic_issue_date());

        docReference.update(updates).addOnCompleteListener(task -> {
            if(task.isSuccessful()) {
                getUserData(firebaseAuth.getUid());
                Toast.makeText(ProfileActivity.this, "Profile Updated Successfully..!", Toast.LENGTH_SHORT).show();
            }
            else {
                Toast.makeText(ProfileActivity.this, task.getException().getMessage(), Toast.LENGTH_SHORT).show();
            }
            progressDialog.dismiss();
        }).addOnFailureListener(e -> {
            Toast.makeText(ProfileActivity.this, e.getMessage(), Toast.LENGTH_SHORT).show();
            progressDialog.dismiss();
        });
    }

    public String getString(EditText editText) {
        return editText.getText().toString().trim();
    }

}