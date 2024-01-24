package com.cuivehari.gasconnectionapp;

import static com.cuivehari.gasconnectionapp.utils.Constants.usersCollection;

import android.Manifest;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.provider.Settings;
import android.util.Log;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import com.cuivehari.gasconnectionapp.databinding.ActivityNewConnectionBinding;
import com.cuivehari.gasconnectionapp.models.NewConnectionModel;
import com.cuivehari.gasconnectionapp.models.UserModel;
import com.cuivehari.gasconnectionapp.utils.CommonValidation;
import com.cuivehari.gasconnectionapp.utils.Dialogs;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.CollectionReference;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;
import com.google.firebase.storage.UploadTask;
import com.karumi.dexter.Dexter;
import com.karumi.dexter.PermissionToken;
import com.karumi.dexter.listener.PermissionDeniedResponse;
import com.karumi.dexter.listener.PermissionGrantedResponse;
import com.karumi.dexter.listener.PermissionRequest;
import com.karumi.dexter.listener.single.PermissionListener;
import com.vansuita.pickimage.bundle.PickSetup;
import com.vansuita.pickimage.dialog.PickImageDialog;
import com.vansuita.pickimage.enums.EPickType;

import java.util.Random;

public class ApplyForConnectionActivity extends AppCompatActivity {

    private static final String ALLOWED_CHARACTERS ="0123456789qwertyuiopasdfghjklzxcvbnmQWERRTUIOPASDFGHJKLZXCVBNM";

    UserModel userModel;
    CommonValidation commonValidation;
    private ProgressDialog progressDialog;
    private Dialog dialog;
    private Uri cnicFrontImageUri, cnicBackImageUri, documentImageUri;

    FirebaseAuth firebaseAuth;
    FirebaseFirestore firebaseFirestore;
    StorageReference storageReference;

    ActivityNewConnectionBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityNewConnectionBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        initWidgets();
    }

    private void initWidgets() {

        commonValidation = new CommonValidation();

        dialog = Dialogs.ProgressLoadingDialog(this);
        progressDialog = Dialogs.MessageProgressDialog(this, "Please Wait...");

        firebaseAuth = FirebaseAuth.getInstance();
        firebaseFirestore = FirebaseFirestore.getInstance();
        storageReference = FirebaseStorage.getInstance().getReference().child("Images/").child(firebaseAuth.getUid() + "/");

        dialog.show();
        getUserData(firebaseAuth.getUid());

        binding.ivSelectFrontImage.setOnClickListener(view -> selectCNICFrontImage());
        binding.ivSelectBackImage.setOnClickListener(view -> selectCNICBackImage());
        binding.ivSelectPDImage.setOnClickListener(view -> selectDocumentImage());
        binding.btnNext.setOnClickListener(view -> applyForConnection());
    }

    private void applyForConnection() {
        if (commonValidation.checkEmpty(binding.edtName, "Applicant Name Required")
                && commonValidation.checkEmpty(binding.edtCNIC, "CNIC No. Required")
                && commonValidation.checkEmpty(binding.edtCNICIssueDate, "CNIC Issue Date Required")
                && commonValidation.checkEmpty(binding.edtMobileNo, "Mobile No. Required")
                && commonValidation.checkEmpty(binding.edtSDWOf, "S/O D/O W/O Required")
                && commonValidation.checkEmpty(binding.edtAddressLine, "Address Required")
                && commonValidation.checkEmpty(binding.edtProvince, "Province Required")
                && commonValidation.checkEmpty(binding.edtCity, "City Required")
                && commonValidation.checkEmpty(binding.edtTypeOfPremises, "Type of Premises Required")
                && commonValidation.checkEmpty(binding.edtAreaOfPremises, "Area of Premises Required"))
        {
            String applicantName = getString(binding.edtName);
            String cnic = getString(binding.edtCNIC);
            String cnicDate = getString(binding.edtCNICIssueDate);
            String phone = getString(binding.edtMobileNo);
            String sdwOf = getString(binding.edtSDWOf);
            String address = getString(binding.edtAddressLine);
            String province = getString(binding.edtProvince);
            String city = getString(binding.edtCity);
            String nearestPlace = getString(binding.edtNearestPlace);
            String consumerNo = getString(binding.edtNearestConsumerNo);
            String typeOfPremises = getString(binding.edtTypeOfPremises);
            String areaOfPremises = getString(binding.edtAreaOfPremises);

            if (cnicFrontImageUri != null && cnicBackImageUri != null)
            {
                if (documentImageUri != null) {
                    NewConnectionModel connectionModel = new NewConnectionModel(applicantName, userModel.getEmail(), phone, cnic, cnicDate, sdwOf, address, province, city, nearestPlace, consumerNo, typeOfPremises, areaOfPremises, firebaseAuth.getUid(), "", "", "", false, false);
                    progressDialog.show();

                    saveInDatabase(connectionModel);
                }
                else {
                    Toast.makeText(ApplyForConnectionActivity.this, "Document Image Requires", Toast.LENGTH_SHORT).show();
                }
            }
            else
            {
                Toast.makeText(ApplyForConnectionActivity.this, "CNIC Front & Back Images Requires", Toast.LENGTH_SHORT).show();
            }
        }
    }

    private void saveInDatabase(NewConnectionModel connectionModel) {

        StorageReference reference = storageReference.child(getRandomString());
        StorageReference reference1 = storageReference.child(getRandomString());
        StorageReference reference2 = storageReference.child(getRandomString());
        UploadTask cnicFUploadTask = reference.putFile(cnicFrontImageUri);
        UploadTask cnicBUploadTask = reference1.putFile(cnicBackImageUri);
        UploadTask cnicDocUploadTask = reference2.putFile(documentImageUri);

        cnicFUploadTask.addOnSuccessListener(taskSnapshot -> {

                    progressDialog.setMessage("Please Wait....");

                    Task<Uri> uri = taskSnapshot.getStorage().getDownloadUrl();
                    while (!uri.isComplete());

                    Uri cnicFDownloadUrl = uri.getResult();
                    connectionModel.setCnic_front_image_url(cnicFDownloadUrl.toString());

                    cnicBUploadTask.addOnSuccessListener(taskSnapshot1 -> {

                                Task<Uri> uri1 = taskSnapshot.getStorage().getDownloadUrl();
                                while (!uri1.isComplete());

                                Uri cnicBDownloadUrl = uri1.getResult();
                                connectionModel.setCnic_back_image_url(cnicBDownloadUrl.toString());

                                cnicDocUploadTask.addOnSuccessListener(taskSnapshot2 -> {

                                            Task<Uri> uri2 = taskSnapshot.getStorage().getDownloadUrl();
                                            while (!uri2.isComplete());

                                            Uri docDownloadUrl = uri2.getResult();
                                            connectionModel.setDocument_image_url(docDownloadUrl.toString());

                                            CollectionReference collectionReference = firebaseFirestore.collection("Applications");
//                                            CollectionReference userCollectionRef = firebaseFirestore.collection("Applications").document(firebaseAuth.getUid()).collection("collectionID");
//
//                                            CollectionReference applicationsCollectionRef = firebaseFirestore.collection("Applications");
//                                            String userID = firebaseAuth.getCurrentUser().getUid();
//                                            CollectionReference collectionRef = applicationsCollectionRef.document(userID).collection(applicationsCollectionRef.document().getId());

                                            collectionReference.add(connectionModel)
                                                    .addOnSuccessListener(documentReference -> {
                                                        Toast.makeText(ApplyForConnectionActivity.this, "Applied for New Connection Successfully....!", Toast.LENGTH_SHORT).show();
                                                        progressDialog.dismiss();
                                                        startActivity(new Intent(ApplyForConnectionActivity.this, ViewChalanActivity.class).putExtra("document_id", documentReference.getId()));
                                                        finish();
                                                    })
                                                    .addOnFailureListener(e -> {
                                                        progressDialog.dismiss();
                                                        Toast.makeText(ApplyForConnectionActivity.this, "Error: " + e.getMessage(), Toast.LENGTH_SHORT).show();
                                                        Log.i("onFailure", e.toString());
                                                    });

                                        })
                                        .addOnFailureListener(e -> {
                                            progressDialog.dismiss();
                                            Toast.makeText(ApplyForConnectionActivity.this, "Error: " + e.getMessage(), Toast.LENGTH_SHORT).show();
                                        })
                                        .addOnProgressListener(taskSnapshot2 -> {
                                            double progress
                                                    = (100.0
                                                    * taskSnapshot.getBytesTransferred()
                                                    / taskSnapshot.getTotalByteCount());
                                            progressDialog.setMessage("Uploaded " + (int)progress + "%");
                                        });

                            })
                            .addOnFailureListener(e -> {
                                progressDialog.dismiss();
                                Toast.makeText(ApplyForConnectionActivity.this, "Error: " + e.getMessage(), Toast.LENGTH_SHORT).show();
                            })
                            .addOnProgressListener(taskSnapshot1 -> {
                                double progress
                                        = (100.0
                                        * taskSnapshot.getBytesTransferred()
                                        / taskSnapshot.getTotalByteCount());
                                progressDialog.setMessage("Uploaded " + (int)progress + "%");
                            });

                })
                .addOnFailureListener(e -> {
                    // Error, Image not uploaded
                    progressDialog.dismiss();
                    Toast.makeText(ApplyForConnectionActivity.this, "Error: " + e.getMessage(), Toast.LENGTH_SHORT).show();
                })
                .addOnProgressListener(taskSnapshot -> {
                    double progress
                            = (100.0
                            * taskSnapshot.getBytesTransferred()
                            / taskSnapshot.getTotalByteCount());
                    progressDialog.setMessage("Uploaded " + (int)progress + "%");
                });
    }

    private void selectCNICFrontImage() {
        Dexter.withContext(ApplyForConnectionActivity.this)
                .withPermission(Manifest.permission.READ_EXTERNAL_STORAGE)
                .withListener(new PermissionListener() {
                    @Override
                    public void onPermissionGranted(PermissionGrantedResponse permissionGrantedResponse) {
                        PickSetup pickSetup = new PickSetup()
                                .setTitle("Select Image")
                                .setPickTypes(EPickType.GALLERY, EPickType.CAMERA)
                                .setCameraButtonText("Take Photo")
                                .setGalleryButtonText("Choose Image")
                                .setButtonOrientation(LinearLayout.VERTICAL);
                        PickImageDialog.build(pickSetup)
                                .setOnPickResult(pickResult -> {
                                    if (pickResult.getError() == null)
                                    {
                                        // Get the Uri of data
                                        cnicFrontImageUri = pickResult.getUri();

                                        //If you want the Bitmap.
                                        binding.ivCNICFrontImage.setImageBitmap(pickResult.getBitmap());
                                    }
                                    else
                                    {
                                        //Handle possible errors
                                        //TODO: do what you have to do with r.getError();
                                        Toast.makeText(ApplyForConnectionActivity.this, pickResult.getError().getMessage() + "", Toast.LENGTH_LONG).show();
                                    }
                                })
                                .setOnPickCancel(() -> {

                                })
                                .show(ApplyForConnectionActivity.this);
                    }

                    @Override
                    public void onPermissionDenied(PermissionDeniedResponse permissionDeniedResponse) {
                        if (permissionDeniedResponse.isPermanentlyDenied())
                        {
                            openSettingsDialog();
                        }
                    }

                    @Override
                    public void onPermissionRationaleShouldBeShown(PermissionRequest permissionRequest, PermissionToken permissionToken) {
                        Toast.makeText(ApplyForConnectionActivity.this, "onPermissionRationaleShouldBeShown", Toast.LENGTH_SHORT).show();
                        permissionToken.continuePermissionRequest();
                    }
                })
                .withErrorListener(error -> Toast.makeText(ApplyForConnectionActivity.this, "There was an error: " + error.toString(), Toast.LENGTH_SHORT).show())
                .onSameThread().check();
    }

    private void selectCNICBackImage() {
        Dexter.withContext(ApplyForConnectionActivity.this)
                .withPermission(Manifest.permission.READ_EXTERNAL_STORAGE)
                .withListener(new PermissionListener() {
                    @Override
                    public void onPermissionGranted(PermissionGrantedResponse permissionGrantedResponse) {
                        PickSetup pickSetup = new PickSetup()
                                .setTitle("Select Image")
                                .setPickTypes(EPickType.GALLERY, EPickType.CAMERA)
                                .setCameraButtonText("Take Photo")
                                .setGalleryButtonText("Choose Image")
                                .setButtonOrientation(LinearLayout.VERTICAL);
                        PickImageDialog.build(pickSetup)
                                .setOnPickResult(pickResult -> {
                                    if (pickResult.getError() == null)
                                    {
                                        // Get the Uri of data
                                        cnicBackImageUri = pickResult.getUri();

                                        //If you want the Bitmap.
                                        binding.ivCNICBackImage.setImageBitmap(pickResult.getBitmap());
                                    }
                                    else
                                    {
                                        Toast.makeText(ApplyForConnectionActivity.this, pickResult.getError().getMessage() + "", Toast.LENGTH_LONG).show();
                                    }
                                })
                                .setOnPickCancel(() -> {

                                })
                                .show(ApplyForConnectionActivity.this);
                    }

                    @Override
                    public void onPermissionDenied(PermissionDeniedResponse permissionDeniedResponse) {
                        if (permissionDeniedResponse.isPermanentlyDenied())
                        {
                            openSettingsDialog();
                        }
                    }

                    @Override
                    public void onPermissionRationaleShouldBeShown(PermissionRequest permissionRequest, PermissionToken permissionToken) {
                        Toast.makeText(ApplyForConnectionActivity.this, "onPermissionRationaleShouldBeShown", Toast.LENGTH_SHORT).show();
                        permissionToken.continuePermissionRequest();
                    }
                })
                .withErrorListener(error -> Toast.makeText(ApplyForConnectionActivity.this, "There was an error: " + error.toString(), Toast.LENGTH_SHORT).show())
                .onSameThread().check();
    }

    private void selectDocumentImage() {
        Dexter.withContext(ApplyForConnectionActivity.this)
                .withPermission(Manifest.permission.READ_EXTERNAL_STORAGE)
                .withListener(new PermissionListener() {
                    @Override
                    public void onPermissionGranted(PermissionGrantedResponse permissionGrantedResponse) {
                        PickSetup pickSetup = new PickSetup()
                                .setTitle("Select Image")
                                .setPickTypes(EPickType.GALLERY, EPickType.CAMERA)
                                .setCameraButtonText("Take Photo")
                                .setGalleryButtonText("Choose Image")
                                .setButtonOrientation(LinearLayout.VERTICAL);
                        PickImageDialog.build(pickSetup)
                                .setOnPickResult(pickResult -> {
                                    if (pickResult.getError() == null)
                                    {
                                        // Get the Uri of data
                                        documentImageUri = pickResult.getUri();

                                        //If you want the Bitmap.
                                        binding.ivPDImage.setImageBitmap(pickResult.getBitmap());
                                    }
                                    else
                                    {
                                        Toast.makeText(ApplyForConnectionActivity.this, pickResult.getError().getMessage() + "", Toast.LENGTH_LONG).show();
                                    }
                                })
                                .setOnPickCancel(() -> {

                                })
                                .show(ApplyForConnectionActivity.this);
                    }

                    @Override
                    public void onPermissionDenied(PermissionDeniedResponse permissionDeniedResponse) {
                        if (permissionDeniedResponse.isPermanentlyDenied())
                        {
                            openSettingsDialog();
                        }
                    }

                    @Override
                    public void onPermissionRationaleShouldBeShown(PermissionRequest permissionRequest, PermissionToken permissionToken) {
                        Toast.makeText(ApplyForConnectionActivity.this, "onPermissionRationaleShouldBeShown", Toast.LENGTH_SHORT).show();
                        permissionToken.continuePermissionRequest();
                    }
                })
                .withErrorListener(error -> Toast.makeText(ApplyForConnectionActivity.this, "There was an error: " + error.toString(), Toast.LENGTH_SHORT).show())
                .onSameThread().check();
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
        binding.edtName.setText(userModel.getUser_name());
        binding.edtCNIC.setText(userModel.getCnic());
        binding.edtMobileNo.setText(userModel.getPhone());
        binding.edtCNICIssueDate.setText(userModel.getCnic_issue_date());
    }

    public void openSettingsDialog()
    {
        AlertDialog.Builder builder = new AlertDialog.Builder(ApplyForConnectionActivity.this);
        builder.setTitle("Storage Permissions Required");
        builder.setMessage("Permission is required for using this app. Please enable them in app settings.");
        builder.setPositiveButton("Go to SETTINGS", (dialog, which) -> {
            dialog.cancel();
            showSettings();
        });
        builder.setNegativeButton("Cancel", (dialog, which) -> dialog.cancel());
        builder.show();
    }

    public void showSettings()
    {
        Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
        Uri uri = Uri.fromParts("package", getPackageName(), null);
        intent.setData(uri);
        startActivityForResult(intent, 101);
    }

    private static String getRandomString()
    {
        final int sizeOfRandomString = ALLOWED_CHARACTERS.length();
        final Random random = new Random();
        final StringBuilder sb = new StringBuilder(sizeOfRandomString);
        for(int i=0; i<sizeOfRandomString; ++i)
            sb.append(ALLOWED_CHARACTERS.charAt(random.nextInt(ALLOWED_CHARACTERS.length())));
        return sb.toString();
    }

    public String getString(EditText editText) {
        return editText.getText().toString().trim();
    }

}