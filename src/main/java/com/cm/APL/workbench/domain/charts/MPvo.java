package com.cm.APL.workbench.domain.charts;

import java.util.ArrayList;
import java.util.List;

public class MPvo {
    private ArrayList<ArrayList<Integer>> data;
    private String[] p;
    private String[] m;

    public ArrayList<ArrayList<Integer>> getData() {
        return data;
    }

    public void setData(ArrayList<ArrayList<Integer>> data) {
        this.data = data;
    }

    public String[] getP() {
        return p;
    }

    public void setP(String[] p) {
        this.p = p;
    }

    public String[] getM() {
        return m;
    }

    public void setM(String[] m) {
        this.m = m;
    }
}
