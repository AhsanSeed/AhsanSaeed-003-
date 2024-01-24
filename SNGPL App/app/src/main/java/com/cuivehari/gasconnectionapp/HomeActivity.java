package com.cuivehari.gasconnectionapp;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import com.cuivehari.gasconnectionapp.databinding.ActivityHomeBinding;
import com.google.firebase.auth.FirebaseAuth;

public class HomeActivity extends AppCompatActivity {

    FirebaseAuth firebaseAuth;
    ActivityHomeBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityHomeBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        initWidgets();
    }

    private void initWidgets() {

        firebaseAuth = FirebaseAuth.getInstance();

        binding.cvNewConnection.setOnClickListener(view -> startActivity(new Intent(HomeActivity.this, ApplyForConnectionActivity.class)));
        binding.cvProfile.setOnClickListener(view -> startActivity(new Intent(HomeActivity.this, ProfileActivity.class)));
//        binding.cvMyApplication.setOnClickListener(view -> startActivity(new Intent(HomeActivity.this, ViewChalanActivity.class)));
        binding.cvMyApplication.setOnClickListener(view -> startActivity(new Intent(HomeActivity.this, MyApplicationsActivity.class)));
        binding.cvReport.setOnClickListener(view -> startActivity(new Intent(HomeActivity.this, ReportActivity.class)));
        binding.cvLogout.setOnClickListener(view -> {
            firebaseAuth.signOut();
            Toast.makeText(HomeActivity.this, "User Logout Successfully....!", Toast.LENGTH_SHORT).show();
            startActivity(new Intent(HomeActivity.this, LoginActivity.class));
            finishAffinity();

        });

    }
}