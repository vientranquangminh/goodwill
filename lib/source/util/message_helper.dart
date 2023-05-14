class MessageHelper {
  static String getChatRoomId(List<String> ids) {
    ids.sort();
    return ids.join('|');
  }
}
