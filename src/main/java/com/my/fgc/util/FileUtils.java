package com.my.fgc.util;

import org.springframework.util.StringUtils;
import sun.security.action.GetPropertyAction;

import java.io.*;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.security.AccessController;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

public class FileUtils {

    /**
     * @desc 扩展   {@link Files#readAllLines }
     * @author wulm
     * @date 2019/6/18 12:06
     * @param bytes
     * @return
     **/
    public static List<String> readAllLines(byte[] bytes) throws IOException {
        return readAllLines(bytes, StandardCharsets.UTF_8);
    }

    /**
     * @desc 扩展   {@link Files#readAllLines }
     * @author wulm
     * @date 2019/6/18 12:06
     * @param bytes
     * @param cs
     * @return
     **/
    public static List<String> readAllLines(byte[] bytes, Charset cs) throws IOException {
        try (BufferedReader reader = newBufferedReader(bytes, cs)) {
            List<String> result = new ArrayList<>();
            for (; ; ) {
                String line = reader.readLine();
                if (line == null)
                    break;
                result.add(line);
            }
            return result;
        }
    }

    /**
     * @desc 扩展   {@link Files#newBufferedReader }
     * @author wulm
     * @date 11:52
     * @param bytes
     * @param cs
     * @return
     **/
    public static BufferedReader newBufferedReader(byte[] bytes, Charset cs)
            throws IOException {
        CharsetDecoder decoder = cs.newDecoder();
        Reader reader = new InputStreamReader(new ByteArrayInputStream(bytes), decoder);
        return new BufferedReader(reader);
    }

    public static String stringsToString(List<String> strs) {
        StringBuilder sb = new StringBuilder();
        for (String str : strs) {
            sb.append(str);
            sb.append(AccessController.doPrivileged(
                    new GetPropertyAction("line.separator")));
        }
        return sb.toString();
    }

    public static byte[] stringsToBytes(List<String> strs) {
        return stringsToString(strs).getBytes(StandardCharsets.UTF_8);
    }

    /**
     * @desc 删除空白行
     * @author wulm
     * @date 2019/6/18 21:25
     * @param strs 内容列表
     * @param isRetainOneEmptyLine 连续多行空白是否保留一行空白
     * @param isTrimNotEmptyLine 是否对内容不为空的行也进行Trim操作
     * @return 内容列表
     **/
    public static List<String> trimLine(List<String> strs, boolean isRetainOneEmptyLine, boolean isTrimNotEmptyLine) {
        ListIterator<String> it = strs.listIterator();
        boolean isExistLastNewLine = false;
        while (it.hasNext()) {
            String next = it.next();
            String trim = next.trim();
            if (StringUtils.isEmpty(trim)) {
                if (isRetainOneEmptyLine) {
                    if (!isExistLastNewLine) {
                        isExistLastNewLine = true;
                        //多个空行保留一行
//                    it.remove();
//                    it.add("");
                    } else {
                        it.remove();
                    }
                } else {
                    it.remove();
                }
            } else {
                isExistLastNewLine = false;
                if (isTrimNotEmptyLine) {
                    it.remove();
                    it.add(trim);
                }
            }
        }
        return strs;
    }

}
