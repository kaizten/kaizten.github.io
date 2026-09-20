# Enumerate

An illustrative example of Java enum is presented below:
```java
package com.kaizten.task.domain.enumerate;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Optional;
import java.util.Random;
import java.util.Set;

public enum KaiztenExitCode {

    OK(0),
    WRONG_INPUTFILE(1),
    TIMEOUT(100),
    ERROR(125),
    INPUTFILE_ERROR(150),
    UNKNOWN(-1);

    public final int code;

    private KaiztenExitCode(int code) {
        this.code = code;
    }

    public static KaiztenExitCode fromString(String stringToCheck) {
        if (stringToCheck == null) {
            throw new NullPointerException();
        }
        stringToCheck = stringToCheck.trim();
        String upperCasedStringToCheck = stringToCheck.toUpperCase();
        for (KaiztenExitCode exitCode : values()) {
            if (exitCode.name().equals(upperCasedStringToCheck)) {
                return exitCode;
            }
        }
        throw new IllegalArgumentException();
    }

    public static int indexOf(String stringToCheck) {
        return KaiztenExitCode
                .fromString(stringToCheck)
                .ordinal();
    }

    public static boolean isValid(String stringToCheck) {
        final Set<String> values = new HashSet<>();
        for (KaiztenExitCode value : KaiztenExitCode.values()) {
            values.add(value.name());
        }
        return values.contains(stringToCheck);
    }

    public static KaiztenExitCode random() {
        return values()[new Random().nextInt(values().length)];
    }

    public static KaiztenExitCode valueOf(int codeToCheck) {
        Optional<KaiztenExitCode> obtainedValue = Arrays.stream(values())
                .filter(KaiztenExitCode -> KaiztenExitCode.code == codeToCheck)
                .findFirst();
        if (obtainedValue.isEmpty()) {
            throw new IllegalArgumentException();
        }
        return obtainedValue.get();
    }
}
```