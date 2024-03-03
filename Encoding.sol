// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Encoding {

    // **Maximum data length for encoding depends on the specific function and data type:**

    // - `combineStrings`, `encodePacked`, and `multiEncodePacked`:
    //   - Limited by the maximum string length supported by the blockchain platform (typically around 32,767 bytes or less).
    // - `encodeNumber`:
    //   - Limited by the size of the data type being encoded (32 bytes for `uint256` in this case).
    // - `encodeString`:
    //   - No inherent limit, but practical limitations exist due to gas costs and storage constraints.

    // Function to combine two strings using abi.encodePacked
    function combineStrings() public pure returns (string memory) {
        return string(abi.encodePacked("Hi, here we are"));
    }

    // Function to encode a number using abi.encode
    function encodeNumber() public pure returns (bytes memory) {
        uint256 number = 1; // Example number
        return abi.encode(number);
    }

    // Function to encode a string using abi.encode
    function encodeString() public pure returns (bytes memory) {
        string memory someString = "some string";
        return abi.encode(someString);
    }

    // Function to combine two strings using abi.encodePacked
    function encodeStringPacked() public pure returns (bytes memory) {
        return abi.encodePacked("some String");
    }

    // Function to create a byte array from a literal string
    function encodeStringBytes() public pure returns (bytes memory) {
        return bytes("some string"); // Creates a byte array, not a string
    }

    // Function to decode a string encoded with abi.encode
    function decodeString() public pure returns (string memory) {
        bytes memory encodedString = encodeString(); // Call the encoding function first
        string memory decodedString = abi.decode(encodedString, (string));
        return decodedString;
    }

    // Function to encode multiple strings using abi.encode
    function mutliEncode() public pure returns (bytes memory) {
        string memory someString1 = "some string";
        string memory someString2 = "it's bigger now";
        return abi.encode(someString1, someString2);
    }

    // Function to decode multiple strings encoded with abi.encode
    function multiDecode() public pure returns (string memory, string memory) {
        bytes memory encodedStrings = mutliEncode(); // Call the encoding function first
        (string memory someString1, string memory someString2) = abi.decode(encodedStrings, (string, string));
        return (someString1, someString2);
    }

    // Function to combine multiple strings using abi.encodePacked
    function multiEncodePacked() public pure returns (bytes memory) {
        return abi.encodePacked("some string", "its bigger nowww");
    }

    // **Explanation for multiDecodePacked:**
    // - `abi.decode` expects data encoded with `abi.encode`, but `abi.encodePacked` returns raw bytes.
    // - Directly casting the encoded bytes to a string can lead to unexpected results and potential security risks.

     // will not work
    function multiDecodePacked() public pure returns(string memory){
    string memory someString7 = abi.decode(multiEncodePacked(),(string));
    return someString7;
    }


    // **Alternative approach for multiDecodePacked:**
    function multiStringCastPacked() public pure returns (string memory) {
        bytes memory encodedString = multiEncodePacked();
        string memory decodedString = ""; // Initialize empty string

        // Iterate over each byte and convert to a character
        for (uint256 i = 0; i < encodedString.length; i++) {
            decodedString = string(abi.encodePacked(decodedString, bytes1(encodedString[i])));
        }

        return decodedString;
    }
}
