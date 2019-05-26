package com.my.ffc.plugin.ffcPlugin;

/**
 * @author wulm
 * @date 2019/5/26 23:20
 * @version 1.0.0
 * @desc
 */
public class PluginConfigProperties {
    private String filePath;
    private FileCreateType fileCreateType;

    public enum FileCreateType {
        OVERWRITE, NOT_OVERWRITE, REPLACE_ONLY_XML
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public FileCreateType getFileCreateType() {
        return fileCreateType;
    }

    public void setFileCreateType(String fileCreateType) {
        switch (fileCreateType) {
            case "0":
                this.fileCreateType = FileCreateType.NOT_OVERWRITE;
                break;
            case "1":
                this.fileCreateType = FileCreateType.OVERWRITE;
                break;
            case "2":
                this.fileCreateType = FileCreateType.REPLACE_ONLY_XML;
                break;
            default:
                throw new RuntimeException("未匹配到类型!!!!!!!!!!!!执行失败!!!!!!!!!!!!!!!!!!!");
        }
    }

    public void setFileCreateType(FileCreateType fileCreateType) {
        this.fileCreateType = fileCreateType;
    }
}
