package com.my.ffc.util;

import org.springframework.util.StringUtils;

import java.io.*;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
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

    public static byte[] stringToBytes(List<String> strs) {
        StringBuilder sb = new StringBuilder();
        boolean isFirst = true;
        for (String str : strs) {
            if (!isFirst) {
                sb.append("\n");
            } else {
                isFirst = false;
            }
            sb.append(str);
        }
        return sb.toString().getBytes(StandardCharsets.UTF_8);
    }

    public static List<String> trimOnlyEmptyLine(List<String> strs) {
        ListIterator<String> it = strs.listIterator();
        boolean isExistLastNewLine = false;
        while (it.hasNext()) {
            String next = it.next();
            if (StringUtils.isEmpty(next.trim())) {
                if (!isExistLastNewLine) {
                    isExistLastNewLine = true;
                    //多个空行保留一行
//                    it.remove();
//                    it.add("");
                } else {
                    it.remove();
                }
            } else {
                isExistLastNewLine = false;
            }
        }
        return strs;
    }

}
