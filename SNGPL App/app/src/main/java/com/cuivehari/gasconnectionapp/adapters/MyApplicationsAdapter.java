package com.cuivehari.gasconnectionapp.adapters;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.cuivehari.gasconnectionapp.databinding.MyApplicationRowBinding;
import com.cuivehari.gasconnectionapp.models.NewConnectionModel;

import java.util.ArrayList;

public class MyApplicationsAdapter extends RecyclerView.Adapter<MyApplicationsAdapter.ViewHolder> {

    final ArrayList<NewConnectionModel> myApplicationsList;
    final Context mContext;

    MyApplicationRowBinding myApplicationRowBinding;

    public MyApplicationsAdapter(Context context, ArrayList<NewConnectionModel> tempList) {
        this.myApplicationsList = tempList;
        this.mContext = context;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        myApplicationRowBinding = MyApplicationRowBinding.inflate(LayoutInflater.from(parent.getContext()), parent, false);
        return new ViewHolder(myApplicationRowBinding);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        NewConnectionModel myApplicationModel = myApplicationsList.get(position);

        holder.binding.tvApplicantName.setText(myApplicationModel.getApplicant_name());
        holder.binding.tvEmailID.setText(myApplicationModel.getEmail());
        holder.binding.tvMobileNo.setText(myApplicationModel.getPhone());
        holder.binding.tvConsumerNo.setText(myApplicationModel.getNearest_consumer_no());
        holder.binding.tvProvince.setText(myApplicationModel.getProvince());
        holder.binding.tvCity.setText(myApplicationModel.getCity());
        holder.binding.tvAddress.setText(myApplicationModel.getAddress());
    }

    @Override
    public int getItemCount() {
        return myApplicationsList.size();
    }

    public static class ViewHolder extends RecyclerView.ViewHolder {

        MyApplicationRowBinding binding;

        public ViewHolder(@NonNull MyApplicationRowBinding itemView) {
            super(itemView.getRoot());
            binding = itemView;
        }
    }
}
