package com.cuivehari.gasconnectionapp;

import static com.cuivehari.gasconnectionapp.utils.Constants.usersCollection;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.widget.EditText;
import android.widget.Toast;

import com.cuivehari.gasconnectionapp.databinding.ActivitySignUpBinding;
import com.cuivehari.gasconnectionapp.models.UserModel;
import com.cuivehari.gasconnectionapp.utils.CommonValidation;
import com.cuivehari.gasconnectionapp.utils.Constants;
import com.cuivehari.gasconnectionapp.utils.Dialogs;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.UserProfileChangeRequest;
import com.google.firebase.firestore.CollectionReference;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.FirebaseFirestore;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

public class SignUpActivity extends AppCompatActivity {

    private final String TAG = "SignUpBinding";

    CommonValidation commonValidation;
    private ProgressDialog progressDialog;

    FirebaseAuth firebaseAuth;
    FirebaseFirestore firebaseFirestore;

    ActivitySignUpBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivitySignUpBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        initWidgets();
    }

    private void initWidgets() {
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

        commonValidation = new CommonValidation();
        progressDialog = Dialogs.MessageProgressDialog(this, "Creating Account...");

        firebaseAuth = FirebaseAuth.getInstance();
        firebaseFirestore = FirebaseFirestore.getInstance();

        binding.btnCreateAccount.setOnClickListener(view -> createUser());
        binding.tvLogin.setOnClickListener(view -> startActivity(new Intent(SignUpActivity.this, LoginActivity.class)));
    }

    private void createUser() {
        if (commonValidation.checkEmpty(binding.edtUsername, "Username Required")
                && commonValidation.checkEmpty(binding.edtEmail, "Email Required")
                && commonValidation.checkEmpty(binding.edtPhone, "Phone Number Required")
                && commonValidation.checkEmpty(binding.edtCNIC, "CNIC Required")
                && commonValidation.checkEmpty(binding.edtCNICIssueDate, "CNIC Issue Date Required")
                && commonValidation.checkEmpty(binding.edtPassword, "Password Required"))
        {
            if (commonValidation.isEmailValid(binding.edtEmail))
            {
                String username = getString(binding.edtUsername);
                String email = getString(binding.edtEmail);
                String phone = getString(binding.edtPhone);
                String cnic = getString(binding.edtCNIC);
                String cnicIssueDate = getString(binding.edtCNICIssueDate);
                String password = getString(binding.edtPassword);

                UserModel userModel = new UserModel(username, email, phone, cnic, cnicIssueDate, password, "");

                progressDialog.show();
                signUpWithFirebase(userModel, password);
            }
        }
    }

    private void signUpWithFirebase(UserModel userModel, String password) {
        firebaseAuth.createUserWithEmailAndPassword(userModel.getEmail(), password)
                .addOnCompleteListener(this, task -> {
                    if (task.isSuccessful()) {
                        Log.d(TAG, "createUserWithEmail:success");
                        FirebaseUser currentUser = firebaseAuth.getCurrentUser();

                        if(currentUser != null) {
                            userModel.setUser_auth_id(currentUser.getUid());
                            saveUserData(userModel);

                            UserProfileChangeRequest profileUpdates = new UserProfileChangeRequest.Builder()
                                    .setDisplayName(userModel.getUser_name()).build();
                            currentUser.updateProfile(profileUpdates);
                        }
                    }
                    else {
                        progressDialog.dismiss();
                        Log.w(TAG, "createUserWithEmail:failure", task.getException());
                        Toast.makeText(SignUpActivity.this, "" + task.getException().getLocalizedMessage(), Toast.LENGTH_SHORT).show();
                    }
                })
                .addOnFailureListener(e -> progressDialog.dismiss());
    }

    private void saveUserData(UserModel userModel) {
        CollectionReference collectionReference = firebaseFirestore.collection(usersCollection);
        DocumentReference docReference = collectionReference.document(userModel.getUser_auth_id());

        docReference.set(userModel)
                .addOnSuccessListener(documentReference -> {
                    progressDialog.dismiss();
                    Log.i("onSuccess", "success");
                    Toast.makeText(SignUpActivity.this, "User Created Successfully....", Toast.LENGTH_SHORT).show();
                    startActivity(new Intent(SignUpActivity.this, HomeActivity.class));
                    finish();
                })
                .addOnFailureListener(e -> {
                    progressDialog.dismiss();
                    Toast.makeText(SignUpActivity.this, e.toString(), Toast.LENGTH_SHORT).show();
                    Log.i("onFailure", e.toString());
                });
    }

    public String getString(EditText editText) {
        return editText.getText().toString().trim();
    }

}