package com.cuivehari.gasconnectionapp.utils;

import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;

import com.cuivehari.gasconnectionapp.R;

public class Dialogs {

    public static Dialog ProgressLoadingDialog(Context mContext) {
        Dialog dialog = new Dialog(mContext);
        View view = LayoutInflater.from(mContext).inflate(R.layout.progress_dialog, null);
        dialog.setCancelable(false);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.setContentView(view);

        return dialog;
    }

    public static ProgressDialog MessageProgressDialog(Context context, String message) {
        ProgressDialog progressDialog = new ProgressDialog(context);
        progressDialog.setMessage(message);
        progressDialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        progressDialog.setCancelable(false);

        return progressDialog;
    }

}
