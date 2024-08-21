import 'package:flutter/material.dart';

class MainPageProvider extends ChangeNotifier{
  int _currentPage = 0;

  void setCurrentPage(int index){
    _currentPage = index;
    notifyListeners();
  }

  void nexPage(){
    _currentPage++;
    notifyListeners();
  }

  void previousPage(){
    _currentPage--;
    notifyListeners();

   void resetPage(){
    _currentPage = 0;
    notifyListeners();
   }
  }

  int get currentPage => _currentPage;
}