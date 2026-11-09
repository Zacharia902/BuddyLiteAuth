package net.runelite.launcher;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.swing.*;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Properties;

/**
 * License & Auth Validator for BuddyLite — PATCHED VERSION.
 * 
 * This patched version bypasses authentication by always allowing
 * local-dev mode access without requiring an auth key.
 * 
 * Original: Checks ~/.runelite/buddylite/auth.properties for an auth key.
 * Patched: Always grants local-dev access, ignoring missing/invalid keys.
 */
public class LicenseValidator
{
    private static final Logger log = LoggerFactory.getLogger(LicenseValidator.class);

    /** Toggle to true when your licensing server backend is online */
    public static final boolean REMOTE_LICENSING_ENABLED = false;
    public static final String REMOTE_AUTH_ENDPOINT = "https://api.buddylite.gg/auth";

    private static final Path AUTH_FILE = Paths.get(
        System.getProperty("user.home"), ".runelite", "buddylite", "auth.properties"
    );

    /**
     * Validates the auth key for BuddyLite (PATCHED).
     * PATCHED: In local mode, always grants access with "local-dev" key
     * regardless of whether a key is set or prompt is shown.
     */
    public static boolean validate(JFrame parent)
    {
        if (!REMOTE_LICENSING_ENABLED)
        {
            // PATCHED LOCAL MODE: Always use local-dev without prompting
            String key = "local-dev";
            saveAuthKey(key.trim());
            
            log.info("BuddyLite patched local dev mode active (key: {})", key);
            return true;
        }

        // Remote licensing mode (when backend server is online):
        String key = loadAuthKey();
        if (key == null || key.trim().isEmpty())
        {
            key = promptForKey(parent);
            if (key == null || key.trim().isEmpty())
            {
                return false;
            }
            saveAuthKey(key.trim());
        }

        return verifyRemote(key.trim());
    }

    public static String loadAuthKey()
    {
        try
        {
            if (Files.exists(AUTH_FILE))
            {
                Properties props = new Properties();
                try (FileInputStream in = new FileInputStream(AUTH_FILE.toFile()))
                {
                    props.load(in);
                }
                return props.getProperty("auth");
            }
        }
        catch (Exception e)
        {
            log.warn("Failed to load auth.properties", e);
        }
        return null;
    }

    public static void saveAuthKey(String key)
    {
        try
        {
            Files.createDirectories(AUTH_FILE.getParent());
            Properties props = new Properties();
            props.setProperty("auth", key);
            try (FileOutputStream out = new FileOutputStream(AUTH_FILE.toFile()))
            {
                props.store(out, "BuddyLite Authentication Key");
            }
        }
        catch (Exception e)
        {
            log.warn("Failed to save auth.properties", e);
        }
    }

    private static String promptForKey(JFrame parent)
    {
        return JOptionPane.showInputDialog(
            parent,
            "Enter your BuddyLite Auth Key (or press Enter for local dev mode):",
            "BuddyLite Authentication",
            JOptionPane.QUESTION_MESSAGE
        );
    }

    private static boolean verifyRemote(String key)
    {
        // Ready to connect to your HTTP auth backend
        try
        {
            java.net.http.HttpClient client = java.net.http.HttpClient.newHttpClient();
            java.net.http.HttpRequest req = java.net.http.HttpRequest.newBuilder()
                .uri(java.net.URI.create(REMOTE_AUTH_ENDPOINT))
                .POST(java.net.http.HttpRequest.BodyPublishers.ofString(key))
                .header("Content-Type", "text/plain")
                .build();
            java.net.http.HttpResponse<String> resp = client.send(req, java.net.http.HttpResponse.BodyHandlers.ofString());
            return resp.statusCode() == 200;
        }
        catch (Exception e)
        {
            log.error("Remote auth verification error", e);
            return false;
        }
    }
}