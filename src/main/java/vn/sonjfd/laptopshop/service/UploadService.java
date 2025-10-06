package vn.sonjfd.laptopshop.service;

import java.io.File;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class UploadService {
    private final String ROOT_PATH = "D:/uploads";

    public String handleSaveUploadFile(MultipartFile file, String targetFolder, String oldFileName) {
        String finalName = "";
        try {
            File dir = new File(ROOT_PATH + File.separator + targetFolder);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            if (oldFileName != null && !oldFileName.isEmpty()) {
                File oldFile = new File(dir.getAbsolutePath() + File.separator + oldFileName);
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }

            finalName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
            File serverFile = new File(dir.getAbsolutePath() + File.separator + finalName);
            file.transferTo(serverFile);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return finalName;
    }
}
