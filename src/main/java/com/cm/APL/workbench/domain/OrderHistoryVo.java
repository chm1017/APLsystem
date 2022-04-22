package com.cm.APL.workbench.domain;

import java.util.Date;

public class OrderHistoryVo {

    private String oid;
    private String oname;
    private Integer pnumber;
    private String createDate;
    private String stage;

    @Override
    public String toString() {
        return "OrderHistoryVo{" +
                "oid='" + oid + '\'' +
                ", oname='" + oname + '\'' +
                ", pnumber=" + pnumber +
                ", createDate=" + createDate +
                ", stage='" + stage + '\'' +
                '}';
    }

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }

    public String getOname() {
        return oname;
    }

    public void setOname(String oname) {
        this.oname = oname;
    }

    public Integer getPnumber() {
        return pnumber;
    }

    public void setPnumber(Integer pnumber) {
        this.pnumber = pnumber;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getstage() {
        return stage;
    }

    public void setstage(String stage) {
        this.stage = stage;
    }
}
