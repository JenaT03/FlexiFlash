import 'package:flutter/foundation.dart';
import '../../models/flashcard.dart';

class FlashcardManager with ChangeNotifier {
  final List<Flashcard> _flashcards = [
    Flashcard(
        id: 'f1',
        text: 'Nấm độc tán trắng',
        imgURL:
            'https://toongadventure.vn/wp-content/uploads/2021/05/lucie-hosova-EFw-2XoOt6w-unsplash-768x512.jpg',
        description:
            '10 loại nấm độc khi trekking xuyên rừng quốc gia Việt Nam. Các trekkers đã ít nhất một lần đến khám phá các khu rừng quốc gia Việt Nam sẽ bất ngờ với hệ sinh thái đa dạng nơi đây. Từ các loài hoa đến các loại quả, đều là những loại thực vật lần đầu tiên bạn nhìn thấy. Việc bắt gặp những loài hoa, thức quả rừng lạ có thể mang đến nhiều trải nghiệm và kiến thức mới lạ. Có thể đó là thứ bạn có thể dùng như một món ăn. Nhưng cũng có những loại thực vật bạn tuyệt đối không thể ăn, đặc biệt là nấm. Bài viết này sẽ giúp bạn hiểu rõ hơn về những loài nấm độc bạn có thể bắt gặp trên chặng đường trekking của mình.Nấm độc tán trắng Loại nấm này có tên khoa học là Amanita Verna. Bạn có thể bắt gặp loại nấm này mọc thành từng cụm hoặc đơn chiếc. Tại Việt Nam, bạn sẽ tìm thấy loài nấm tán trắng này ở các tỉnh phía Bắc như Hà Giang, Tuyên Quang, Thái Nguyên, Yên Bái, Bắc Cạn, Phú Thọ…',
        deckId: 'd1',
        language: 'vi-VN'),
    Flashcard(
        id: 'f2',
        text: 'Nấm phiến đốm chuông',
        imgURL:
            'https://toongadventure.vn/wp-content/uploads/2021/…1-0-2ef4e0e42889ca05c07f8f3bee359d30-768x512.jpeg',
        description:
            'Mũ nấm hình chuông, đường kính từ 2 đến 3.5cm. Các phiến có vân, màu xanh rồi đen. Nấm có lớp thịt mỏng, màu da sơn dương.  Những chất độc gây ảo giác nằm ở phiến đốm chuông không mùi.  Bạn có thể tìm thấy nấm phiến đốm chuông trên phân hoại mục ở các bãi cỏ từ tháng 1 đến tháng 9 hằng năm.',
        deckId: 'd1',
        language: 'vi-VN'),
    Flashcard(
        id: 'f3',
        text: 'Superposition - Chồng chập  lượng tử',
        description:
            'Ở tầng mức lượng tử, các nhà khoa học phát hiện ra rằng quỹ đạo di chuyển của các hạt này gần như không thể được nắm bắt, phỏng đoán một cách chính xác. Đối với vật lý cổ điển, thì việc này quả thực phi logic và khó có thể chấp nhận được.',
        imgURL:
            'https://happy.live/wp-content/uploads/2021/05/vat-ly-luong-tu-happy-live3.jpg',
        deckId: 'd2',
        language: 'vi-VN'),
    Flashcard(
        id: 'f4',
        text: 'Quantum Entanglement - Vướng mắt lượng tử',
        description:
            '2 hạt (ví dụ: electron), dù ở cách xa nhau vô cùng (ví dụ: 1 hạt ở cực Bắc & 1 hạt ở cực Nam Trái Đất), thì một khi chúng ta tác động vào 1 electron bất kỳ trong cặp này, electron còn lại cũng sẽ ngay lập tức bị ảnh hưởng, mặc dù giữa chúng không có mối liên hệ rõ ràng nào. Cứ như thể các electron có khả năng tương tác, “trao đổi” thông tin từ xa với nhau vậy',
        imgURL: '',
        deckId: 'd2',
        language: 'vi-VN'),
    Flashcard(
        id: 'f5',
        text: 'Bồ câu Nicoba',
        description:
            'Bồ câu Nicoba (danh pháp hai phần: Caloenas nicobarica) là một loài bồ câu được tìm thấy tại các hòn đảo nhỏ và những vùng bờ biển tại quần đảo Nicobar, miền đông tới quần đảo Mã Lai, và đến Solomon và Palau. Nó hiện là thành viên duy nhất của chi Caloenas, và là họ hàng gần nhất còn tồn tại của chim dodo.',
        imgURL:
            'https://img.giaoduc.net.vn/w700/Uploaded/2025/fcivpcvo/2012_09_11/cac-loai-dong-vat-co-trong-sach-do-viet-nam-128.jpg',
        deckId: 'd3',
        language: 'vi-VN'),
    Flashcard(
        id: 'f6',
        text: 'Bồ chanh rừng',
        description:
            'Bồng chanh rừng (danh pháp hai phần: Alcedo hercules) là loài chim bói cá lớn nhất thuộc chi Alcedo, họ Bồng chanh. Bồng chanh rừng dài từ 22 đến 23 cm, có phần ngực và bụng xù xì với mảng ngực màu xanh đen, phần trên màu lam cobalt hoặc xanh da trời rực rỡ, nhuốm màu tím. ',
        imgURL:
            'https://img.giaoduc.net.vn/w700/Uploaded/2025/fcivpcvo/2012_09_11/cac-loai-dong-vat-co-trong-sach-do-viet-nam-129.jpg',
        deckId: 'd3',
        language: 'vi-VN'),
    Flashcard(
        id: 'f7',
        text: 'Scandi',
        imgURL:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Scandium_sublimed_dendritic_and_1cm3_cube.jpg/330px-Scandium_sublimed_dendritic_and_1cm3_cube.jpg',
        description:
            'Scandi hay scandium là một nguyên tố hóa học trong bảng tuần hoàn có ký hiệu Sc và số nguyên tử bằng 21. Là một kim loại chuyển tiếp mềm, màu trắng bạc, scandi có trong các khoáng chất hiếm ở Scandinavia ',
        deckId: 'd4',
        language: 'vi-VN'),
    Flashcard(
        id: 'f8',
        text: 'Ytri',
        imgURL:
            'https://upload.wikimedia.org/wikipedia/commons/thu…endritic.jpg/330px-Yttrium_sublimed_dendritic.jpg',
        description:
            'Ytri là một nguyên tố hóa học có ký hiệu Y và số nguyên tử 39. Là một kim loại chuyển tiếp màu trắng bạc, ytri khá phổ biến trong các khoáng vật đất hiếm và hai trong số các hợp chất của nó được sử dụng làm lân quang màu đỏ trong các ống tia âm cực, chẳng hạn trong các ống dùng cho truyền hình.',
        deckId: 'd4',
        language: 'vi-VN'),
    Flashcard(
        id: 'f9',
        text: 'George Washington',
        imgURL:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Gilbert_Stuart_Williamstown_Portrait_of_George_Washington_%28cropped%29%282%29.jpg/225px-Gilbert_Stuart_Williamstown_Portrait_of_George_Washington_%28cropped%29%282%29.jpg',
        description:
            'George Washington[c] (22 tháng 2 năm 1732 / 14 tháng 12 năm 1799) là một nhà lãnh đạo quân sự, chính khách người Mỹ, một trong những người lập quốc, tổng thống đầu tiên của Hoa Kỳ từ năm 1789 đến năm 1797',
        deckId: 'd5',
        language: 'vi-VN'),
    Flashcard(
        id: 'f10',
        text: 'Thomas Jefferson',
        imgURL:
            'https://upload.wikimedia.org/wikipedia/commons/thu…x-Thomas_Jefferson_by_Rembrandt_Peale%2C_1800.jpg',
        description:
            'Thomas Jefferson (13 tháng 4 năm 1743 / 4 tháng 7 năm 1826) là chính khách, nhà ngoại giao, luật sư, kiến trúc sư, nhà triết học người Mỹ. Ông là một trong các kiến quốc phụ của Hợp chúng quốc Hoa Kỳ và là tổng thống thứ 3 của Hợp Chúng Quốc Hoa Kỳ',
        deckId: 'd5',
        language: 'vi-VN'),
    Flashcard(
        id: 'f11',
        text: 'EVEREST',
        imgURL:
            'https://danviet.mediacdn.vn/296231569849192448/2024/4/19/everest-top-10-dinh-nui-cao-nhat-the-gioi-hien-nay-1713518663885-17135186640951526466027.jpg',
        description:
            'Độ cao 8.850m. Ngọn núi này được biết đến với danh xưng nóc nhà của thế giới. Everest thuộc dãy núi Khumbu Himalaya của Nepal. Hàng năm, đỉnh núi này trở thành đích đến của hàng ngàn tay leo núi kỳ cựu trên toàn thế giới.',
        deckId: 'd6',
        language: 'vi-VN'),
    Flashcard(
        id: 'f12',
        text: 'ĐỈNH K2',
        imgURL:
            '	https://danviet.mediacdn.vn/296231569849192448/202…ien-nay-1713518666534-17135186666431858510310.jpg',
        description:
            'Đỉnh núi K2 còn được biết đến với nhiều tên gọi khác nhau. Như Godwin-Austen, Lambha Pahar, Chogori, Kechu hay Dapsang. Với chiều cao 8.600m so với mực nước biển, nó chính là điểm đến khát khao của những tay leo núi kỳ cựu.',
        deckId: 'd6',
        language: 'vi-VN'),
  ];

  // Getter để lấy tất cả flashcard
  List<Flashcard> get flashcards => [..._flashcards];

  // Getter để lấy số lượng flashcard
  int get flashcardCount => _flashcards.length;

  // Tìm flashcard theo id
  Flashcard? findById(String id) {
    try {
      return _flashcards.firstWhere((flashcard) => flashcard.id == id);
    } catch (error) {
      return null;
    }
  }

  // Lấy flashcard theo deckId
  List<Flashcard> getFlashcardsByDeck(String deckId) {
    return _flashcards
        .where((flashcard) => flashcard.deckId == deckId)
        .toList();
  }

  // Thêm flashcard mới
  void addFlashcard(Flashcard flashcard) {
    final newFlashcard = flashcard.copyWith(
      id: 'f${DateTime.now().toIso8601String()}',
    );
    _flashcards.add(newFlashcard);
    notifyListeners();
  }

  // Thêm nhiều flashcard cùng lúc
  void addMultipleFlashcards(List<Flashcard> flashcards) {
    for (var flashcard in flashcards) {
      addFlashcard(flashcard);
    }
  }

  // Cập nhật flashcard
  void updateFlashcard(Flashcard flashcard) {
    final index = _flashcards.indexWhere((item) => item.id == flashcard.id);
    if (index >= 0) {
      _flashcards[index] = flashcard;
      notifyListeners();
    }
  }

  // Xóa flashcard
  void deleteFlashcard(String id) {
    final index = _flashcards.indexWhere((flashcard) => flashcard.id == id);
    if (index >= 0) {
      _flashcards.removeAt(index);
      notifyListeners();
    }
  }

  // Xóa tất cả flashcard của một deck
  void deleteFlashcardsInDeck(String deckId) {
    _flashcards.removeWhere((flashcard) => flashcard.deckId == deckId);
    notifyListeners();
  }

  // Đếm số flashcard trong một deck
  int countFlashcardsInDeck(String deckId) {
    return _flashcards.where((flashcard) => flashcard.deckId == deckId).length;
  }
}
