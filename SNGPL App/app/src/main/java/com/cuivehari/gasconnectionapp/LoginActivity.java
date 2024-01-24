package com.cuivehari.gasconnectionapp;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.Toast;

import com.cuivehari.gasconnectionapp.databinding.ActivityLoginBinding;
import com.cuivehari.gasconnectionapp.databinding.ActivitySignUpBinding;
import com.cuivehari.gasconnectionapp.databinding.ForgotPassBottomSheetDialogBinding;
import com.cuivehari.gasconnectionapp.utils.CommonValidation;
import com.cuivehari.gasconnectionapp.utils.Dialogs;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.Task;
import com.google.android.material.bottomsheet.BottomSheetBehavior;
import com.google.android.material.bottomsheet.BottomSheetDialog;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.firestore.FirebaseFirestore;

import java.util.Objects;

public class LoginActivity extends AppCompatActivity {

    private final String TAG = "LoginBinding";

    CommonValidation commonValidation;
    private Dialog progressDialog;

    FirebaseAuth firebaseAuth;
    FirebaseFirestore firebaseFirestore;

    ActivityLoginBinding binding;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityLoginBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        initWidgets();
    }

    @Override
    public void onStart() {
        super.onStart();

        // Checking if the user is signed in (non-null) and update UI accordingly.
        FirebaseUser currentUser = firebaseAuth.getCurrentUser();

        if (currentUser != null) {

            Intent intent = new Intent(LoginActivity.this, HomeActivity.class);
            startActivity(intent);
            finish();
        }
    }

    private void initWidgets() {

        commonValidation = new CommonValidation();
        progressDialog = Dialogs.ProgressLoadingDialog(this);

        firebaseAuth = FirebaseAuth.getInstance();
        firebaseFirestore = FirebaseFirestore.getInstance();

        binding.btnLogin.setOnClickListener(view -> loginUser());
        binding.btnCreateAccount.setOnClickListener(view -> startActivity(new Intent(LoginActivity.this, SignUpActivity.class)));
        binding.tvForgotPassword.setOnClickListener(view -> showBottomSheetDialog());
        
    }

    private void loginUser() {
        if (commonValidation.checkEmpty(binding.edtEmail, "Email Required")
                && commonValidation.checkEmpty(binding.edtPassword, "Password Required"))
        {
            if (commonValidation.isEmailValid(binding.edtEmail))
            {
                String email = getString(binding.edtEmail);
                String password = getString(binding.edtPassword);

                progressDialog.show();
                loginWithFirebase(email, password);
            }
        }
    }

    private void loginWithFirebase(String email, String password) {
        firebaseAuth.signInWithEmailAndPassword(email, password)
                .addOnCompleteListener(this, task -> {
                    if (task.isSuccessful())
                    {
                        Log.d(TAG, "signInWithEmailAndPassword:success");
                        FirebaseUser currentUser = firebaseAuth.getCurrentUser();

                        if(currentUser != null)
                        {
                            Toast.makeText(LoginActivity.this, "User Login Successfully....!", Toast.LENGTH_SHORT).show();
                            Intent intent = new Intent(LoginActivity.this, HomeActivity.class);
                            startActivity(intent);
                            finish();
                        }
                    }
                    else {
                        progressDialog.dismiss();
                        Log.w(TAG, "createUserWithEmail:failure", task.getException());
                        Toast.makeText(LoginActivity.this, "" + task.getException().getLocalizedMessage(), Toast.LENGTH_SHORT).show();
                    }
                });
    }

    private void showBottomSheetDialog() {

        BottomSheetDialog bottomSheetDialog = new BottomSheetDialog(this, R.style.BottomSheetDialogTheme);
        bottomSheetDialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
        bottomSheetDialog.getBehavior().setState(BottomSheetBehavior.STATE_EXPANDED);
        ForgotPassBottomSheetDialogBinding mBottomSheetBinding = ForgotPassBottomSheetDialogBinding.inflate(getLayoutInflater(), null, false);
        bottomSheetDialog.setContentView(mBottomSheetBinding.getRoot());

        mBottomSheetBinding.edtForgotPassEmail.addTextChangedListener(new TextWatcher() {

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void onTextChanged(CharSequence charSequence, int start, int before, int count) {
                String text = charSequence.toString();
            }

            @Override
            public void afterTextChanged(Editable s) {
            }

        });

        mBottomSheetBinding.btnForgotPassSubmit.setOnClickListener(view -> {
            if(commonValidation.checkEmpty(mBottomSheetBinding.edtForgotPassEmail, "Email Required")) {
                if (commonValidation.isEmailValid(mBottomSheetBinding.edtForgotPassEmail)) {
                    progressDialog.show();
                    String email = getString(mBottomSheetBinding.edtForgotPassEmail);
                    firebaseAuth.sendPasswordResetEmail(email)
                            .addOnCompleteListener(task -> {
                                if (task.isSuccessful()) {
                                    Log.d(TAG, "Email sent.");
                                    Toast.makeText(getApplicationContext(), "Check Your Email", Toast.LENGTH_SHORT).show();
                                    bottomSheetDialog.dismiss();
                                }
                                else {
                                    Toast.makeText(getApplicationContext(), task.getException().getMessage(), Toast.LENGTH_SHORT).show();
                                }
                                progressDialog.dismiss();
                            })
                            .addOnFailureListener(e -> {
                                Toast.makeText(getApplicationContext(), e.getMessage(), Toast.LENGTH_SHORT).show();
                                progressDialog.dismiss();
                            });
                }
            }
        });
        mBottomSheetBinding.tvRememberLogin.setOnClickListener(view -> bottomSheetDialog.dismiss());

        bottomSheetDialog.show();
    }

    public String getString(EditText editText) {
        return editText.getText().toString().trim();
    }

}