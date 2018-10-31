package teamwish.duty.dataContracts.cases;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.sql.Date;
import java.sql.Timestamp;

import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
@ApiModel(description = "CaseType信息")
public class CaseType {
    @ApiModelProperty(value = "类型Id")
    private String caseTypeIDS;
    @ApiModelProperty(value = "类型名称")
    private String caseType;
    @ApiModelProperty(value = "上级类型名称")
    private String parentType;
    @ApiModelProperty(value = "上级类型Id")
    private String parentTypeIDS;
    @ApiModelProperty(value = "isLeftChild")
    private Boolean isLeftChild;
    @ApiModelProperty(value = "stanCaseTypeIDS")
    private String stanCaseTypeIDS;
    @ApiModelProperty(value = "stanCaseType")
    private String stanCaseType;
    @ApiModelProperty(value = "provinceCaseTypeIDS")
    private String provinceCaseTypeIDS;
    @ApiModelProperty(value = "provinceCaseType")
    private String provinceCaseType;
    @ApiModelProperty(value = "treeParentIDS")
    private String treeParentIDS;
    @ApiModelProperty(value = "treeIndx")
    private String treeIndx;
    @ApiModelProperty(value = "id")
    private Integer id;
    @ApiModelProperty(value = "isUsed")
    private Boolean isUsed;
    @ApiModelProperty(value = "dSId")
    private Integer dSId;

    public String getCaseTypeIDS() {
        return this.caseTypeIDS;
    }

    public void setCaseTypeIDS(String caseTypeIDS) {
        this.caseTypeIDS = caseTypeIDS;
    }

    public String getCaseType() {
        return this.caseType;
    }

    public void setCaseType(String caseType) {
        this.caseType = caseType;
    }

    public String getParentType() {
        return this.parentType;
    }

    public void setParentType(String parentType) {
        this.parentType = parentType;
    }

    public String getParentTypeIDS() {
        return this.parentTypeIDS;
    }

    public void setParentTypeIDS(String parentTypeIDS) {
        this.parentTypeIDS = parentTypeIDS;
    }

    public Boolean getIsLeftChild() {
        return this.isLeftChild;
    }

    public void setIsLeftChild(Boolean isLeftChild) {
        this.isLeftChild = isLeftChild;
    }

    public String getStanCaseTypeIDS() {
        return this.stanCaseTypeIDS;
    }

    public void setStanCaseTypeIDS(String stanCaseTypeIDS) {
        this.stanCaseTypeIDS = stanCaseTypeIDS;
    }

    public String getStanCaseType() {
        return this.stanCaseType;
    }

    public void setStanCaseType(String stanCaseType) {
        this.stanCaseType = stanCaseType;
    }

    public String getProvinceCaseTypeIDS() {
        return this.provinceCaseTypeIDS;
    }

    public void setProvinceCaseTypeIDS(String provinceCaseTypeIDS) {
        this.provinceCaseTypeIDS = provinceCaseTypeIDS;
    }

    public String getProvinceCaseType() {
        return this.provinceCaseType;
    }

    public void setProvinceCaseType(String provinceCaseType) {
        this.provinceCaseType = provinceCaseType;
    }

    public String getTreeParentIDS() {
        return this.treeParentIDS;
    }

    public void setTreeParentIDS(String treeParentIDS) {
        this.treeParentIDS = treeParentIDS;
    }

    public String getTreeIndx() {
        return this.treeIndx;
    }

    public void setTreeIndx(String treeIndx) {
        this.treeIndx = treeIndx;
    }

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Boolean getIsUsed() {
        return this.isUsed;
    }

    public void setIsUsed(Boolean isUsed) {
        this.isUsed = isUsed;
    }

    public Integer getDSId() {
        return this.dSId;
    }

    public void setDSId(Integer dSId) {
        this.dSId = dSId;
    }
}
