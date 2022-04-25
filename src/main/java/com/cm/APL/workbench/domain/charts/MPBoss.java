package com.cm.APL.workbench.domain.charts;

public class MPBoss {
    private String mname;
    private String pname;
    private Integer tol;

    @Override
    public String toString() {
        return "MPBoss{" +
                "mname='" + mname + '\'' +
                ", pname='" + pname + '\'' +
                ", tol=" + tol +
                '}';
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public Integer getTol() {
        return tol;
    }

    public void setTol(Integer tol) {
        this.tol = tol;
    }
}
