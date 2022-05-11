package com.cm.APL.workbench.domain.charts;

import java.util.ArrayList;
import java.util.List;

public class MPvo {
    private ArrayList<ArrayList<Integer>> data;
    private List<String> p;
    private List<String> m;

    public List<String> getP() {
        return p;
    }

    public void setP(List<String> p) {
        this.p = p;
    }

    public List<String> getM() {
        return m;
    }

    public void setM(List<String> m) {
        this.m = m;
    }

    public ArrayList<ArrayList<Integer>> getData() {
        return data;
    }

    public void setData(ArrayList<ArrayList<Integer>> data) {
        this.data = data;
    }


}
