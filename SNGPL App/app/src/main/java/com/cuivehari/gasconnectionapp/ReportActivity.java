package com.cuivehari.gasconnectionapp;

import static com.cuivehari.gasconnectionapp.dialogs.Dialogs.showAlert;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.Toast;

import com.cuivehari.gasconnectionapp.databinding.ActivityLoginBinding;
import com.cuivehari.gasconnectionapp.databinding.ActivityReportBinding;
import com.cuivehari.gasconnectionapp.utils.CommonValidation;

public class ReportActivity extends AppCompatActivity {

    CommonValidation commonValidation;

    ActivityReportBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityReportBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        initWidgets();
    }

    private void initWidgets() {
        commonValidation = new CommonValidation();

        binding.btnSubmit.setOnClickListener(view -> submitReport());
    }

    private void submitReport() {
        if (commonValidation.checkEmpty(binding.edtTitle, "Title Required")
                && commonValidation.checkEmpty(binding.edtDetails, "Details Required"))
        {
            binding.edtTitle.setText("");
            binding.edtDetails.setText("");
            String message = "Please Contact on these Mobile No: \nKhalid Mehmood: +92304-9830984\nZahid ALi: +92312-9812053";
            Toast.makeText(this, "Your Report Submitted Successfully..!", Toast.LENGTH_SHORT).show();
            showAlert(message, ReportActivity.this);
        }
    }

}