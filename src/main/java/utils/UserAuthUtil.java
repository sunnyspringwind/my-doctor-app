package utils;

import org.mindrot.jbcrypt.BCrypt;

/** utility class for authentication related stuff */
public class UserAuthUtil {

    /** Compare the entered password (after hashing) with the stored hash */
    public static boolean authenticateUser(String enteredPassword, String storedHash) {
        return BCrypt.checkpw(enteredPassword, storedHash);
    }
}
