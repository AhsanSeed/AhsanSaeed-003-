package com.cuivehari.gasconnectionapp;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;

import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.cuivehari.gasconnectionapp.adapters.MyApplicationsAdapter;
import com.cuivehari.gasconnectionapp.databinding.ActivityMyApplicationsBinding;
import com.cuivehari.gasconnectionapp.models.NewConnectionModel;
import com.cuivehari.gasconnectionapp.utils.Dialogs;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.DocumentSnapshot;
import com.google.firebase.firestore.FirebaseFirestore;

import java.util.ArrayList;
import java.util.List;

public class MyApplicationsActivity extends AppCompatActivity {

    ArrayList<NewConnectionModel> myApplicationsList;
    MyApplicationsAdapter myApplicationsAdapter;

    private Dialog dialog;

    FirebaseFirestore firebaseFirestore;
    FirebaseAuth firebaseAuth;

    ActivityMyApplicationsBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityMyApplicationsBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());
        initWidgets();
    }

    private void initWidgets() {
        firebaseFirestore = FirebaseFirestore.getInstance();
        firebaseAuth = FirebaseAuth.getInstance();
        dialog = Dialogs.ProgressLoadingDialog(this);
        dialog.show();

        myApplicationsList = new ArrayList<>();

        binding.rvAllApplications.setLayoutManager(new LinearLayoutManager(this));
        myApplicationsAdapter = new MyApplicationsAdapter(this, myApplicationsList);
        binding.rvAllApplications.setAdapter(myApplicationsAdapter);

        getMyApplications();
    }

    private void getMyApplications() {
        myApplicationsList.clear();

        firebaseFirestore.collection("Applications").get()
                .addOnSuccessListener(documentSnapshots -> {
                    if (!documentSnapshots.isEmpty()) {
                        List<NewConnectionModel> allDataList = documentSnapshots.toObjects(NewConnectionModel.class);

                        Log.d("TAG", "onSuccess: " + allDataList.size());
                        for (NewConnectionModel newConnectionModel : allDataList) {
                            if(newConnectionModel.getUser_auth_id().equals(firebaseAuth.getCurrentUser().getUid())) {
                                myApplicationsList.add(newConnectionModel);
                            }
                        }
                        myApplicationsAdapter.notifyDataSetChanged();

                        if(myApplicationsList.isEmpty()) {
                            binding.tvNoApplications.setVisibility(View.VISIBLE);
                            binding.rvAllApplications.setVisibility(View.GONE);
                        }
                        else {
                            binding.tvNoApplications.setVisibility(View.GONE);
                            binding.rvAllApplications.setVisibility(View.VISIBLE);
                        }
                    }

                    dialog.dismiss();
                }).addOnFailureListener(e -> {
                    dialog.dismiss();
                    Toast.makeText(MyApplicationsActivity.this, "Error getting data!!!", Toast.LENGTH_SHORT).show();
                });
    }


}