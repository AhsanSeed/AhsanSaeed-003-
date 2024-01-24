package com.cuivehari.gasconnectionapp;

import static android.os.Build.VERSION.SDK_INT;
import static android.provider.Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.FileProvider;

import android.Manifest;
import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.ClipData;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.cuivehari.gasconnectionapp.databinding.ActivityViewChalanBinding;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.CollectionReference;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.FirebaseFirestore;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Header;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Map;

public class ViewChalanActivity extends AppCompatActivity {

    // Static CONSTANT VALUE
    private static final int REQUEST_EXTERNAL_STORAGE = 1;
    private static final String[] PERMISSION_STORAGE = {
            Manifest.permission.READ_EXTERNAL_STORAGE,
            Manifest.permission.WRITE_EXTERNAL_STORAGE,
    };

    String chalanID;

    FirebaseAuth firebaseAuth;
    FirebaseFirestore firebaseFirestore;

    ActivityViewChalanBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityViewChalanBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        initWidgets();
    }

    private void initWidgets() {

        chalanID = getIntent().getStringExtra("document_id");
        firebaseAuth = FirebaseAuth.getInstance();
        firebaseFirestore = FirebaseFirestore.getInstance();

        verifyStoragePermission();
        generatePDFChalan();
        binding.btnViewChalan.setOnClickListener(view -> openPDF());
    }

    private void generatePDFChalan() {
        // Create a new document
        Document document = new Document();

        // Set the path and filename for the PDF
        String filePath = Environment.getExternalStorageDirectory().getPath() + "/" + firebaseAuth.getUid() + "_chalan_form.pdf";

        try {
            // Create a PdfWriter instance
            PdfWriter.getInstance(document, new FileOutputStream(filePath));

            // Open the document
            document.open();

            // Add content to the document
            // You can get the values from your input fields and add them to the document as paragraphs or tables
            // For example:
            document.add(new Header("Header 1", "This is the header here...."));
            document.add(new Paragraph("Section 1"));
            document.add(new Paragraph("editTextSection1.getText().toString()"));
            document.add(new Paragraph("Section 2"));
            document.add(new Paragraph("editTextSection2.getText().toString()"));
            document.add(new Paragraph("Section 3"));
            document.add(new Paragraph("editTextSection3.getText().toString()"));

            // Close the document
            document.close();

//            updateChalanToDatabase();
            binding.btnViewChalan.setVisibility(View.VISIBLE);
            binding.progresBar.setVisibility(View.GONE);
            updateChalanToDatabase();

            // Show a success message or open the generated PDF
            binding.tvError.setText("Chalan Form Generated Successfully. Click the button below to view it.");
        } catch (DocumentException | FileNotFoundException e) {
            Log.d("generatePDFChalan", "Exception: " + e.getMessage());
            Toast.makeText(this, "Exception: " + e.getMessage(), Toast.LENGTH_SHORT).show();
            e.printStackTrace();
        }
    }

    private void updateChalanToDatabase() {
        CollectionReference collectionReference = firebaseFirestore.collection("Applications");
        DocumentReference docReference = collectionReference.document(chalanID);

        Map<String, Object> updates = new HashMap<>();
        updates.put("is_chalan_generated", true);

        docReference.update(updates).addOnCompleteListener(task -> {
            if(task.isSuccessful()) {
                Toast.makeText(ViewChalanActivity.this, "Chalan Updated Successfully..!", Toast.LENGTH_SHORT).show();
            }
            else {
                Toast.makeText(ViewChalanActivity.this, task.getException().getMessage(), Toast.LENGTH_SHORT).show();
            }
        }).addOnFailureListener(e -> {
            Toast.makeText(ViewChalanActivity.this, e.getMessage(), Toast.LENGTH_SHORT).show();
        });

    }
    // Access pdf from storage and using to Intent get options to view application in available applications.
    private void openPDF() {

        // Get the File location and file name.
        File file = new File(Environment.getExternalStorageDirectory(), firebaseAuth.getUid() + "_chalan_form.pdf");
        Log.d("openPDF", "pdfFIle: " + file);

        // Get the URI Path of file.
        Uri uriPdfPath = FileProvider.getUriForFile(this, getApplicationContext().getPackageName() + ".provider", file);
        Log.d("openPDF", "pdfPath: " + uriPdfPath);

        // Start Intent to View PDF from the Installed Applications.
        Intent pdfOpenIntent = new Intent(Intent.ACTION_VIEW);
        pdfOpenIntent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        pdfOpenIntent.setClipData(ClipData.newRawUri("", uriPdfPath));
        pdfOpenIntent.setDataAndType(uriPdfPath, "application/pdf");
        pdfOpenIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION |  Intent.FLAG_GRANT_WRITE_URI_PERMISSION);

        try {
            startActivity(pdfOpenIntent);
        } catch (ActivityNotFoundException activityNotFoundException) {
            Toast.makeText(this,"There is no app to load corresponding PDF",Toast.LENGTH_LONG).show();

        }
    }

    //Permissions Check
    public void verifyStoragePermission() {
        int permission = ActivityCompat.checkSelfPermission(ViewChalanActivity.this, Manifest.permission.WRITE_EXTERNAL_STORAGE);

        // Surrounded with if statement for Android R to get access of complete file.
        if (SDK_INT >= Build.VERSION_CODES.R) {
            if (!Environment.isExternalStorageManager() && permission != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(
                        ViewChalanActivity.this,
                        PERMISSION_STORAGE,
                        REQUEST_EXTERNAL_STORAGE);

                // Abruptly we will ask for permission once the application is launched for sake demo.
                Intent intent = new Intent();
                intent.setAction(ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
                Uri uri = Uri.fromParts("package", this.getPackageName(), null);
                intent.setData(uri);
                startActivity(intent);
            }
        }
    }
}