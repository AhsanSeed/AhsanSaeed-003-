package com.cuivehari.gasconnectionapp.dialogs;

import android.app.Activity;

import androidx.appcompat.app.AlertDialog;

public class Dialogs {

    public static void showAlert(String message, Activity context) {

        final AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder.setMessage(message).setCancelable(false)
                .setPositiveButton("OK", (dialog, id) -> dialog.dismiss());
        try {
            builder.show();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
