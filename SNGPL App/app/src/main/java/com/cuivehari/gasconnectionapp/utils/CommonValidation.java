package com.cuivehari.gasconnectionapp.utils;

import android.util.Patterns;
import android.widget.EditText;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CommonValidation {

    public boolean isEmailValid(EditText editText) {
        String email = editText.getText().toString().trim();
        boolean valid = Patterns.EMAIL_ADDRESS.matcher(email).matches();
        if (valid)
        {
            return true;
        }
        else
        {
            editText.requestFocus();
            editText.setError("Enter Valid Email");
            return false;
        }
    }

    public static boolean isPasswordValidMethod(String password) {

        boolean isValid = false;

        // ^[_A-Za-z0-9-\+]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})$
        // ^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{2,4}$

        String PASSWORD_PATTERN = "^(?=.*[A-Z])(?=.*[@_.]).*$";

        Pattern pattern = Pattern.compile(PASSWORD_PATTERN, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(password);
        if (!password.matches(".*\\d.*") || !matcher.matches()) {
            isValid = true;
        }

        return isValid;
    }

    public boolean checkEmpty(EditText editText, String errorMsg) {
        if (editText.getText().toString().trim().length() == 0)
        {
            editText.requestFocus();
            editText.setError(errorMsg);
            return false;
        }
        else
        {
            return true;
        }
    }

}
