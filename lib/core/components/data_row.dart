
import 'package:flutter/material.dart';

createTitleCell(String name, bool isEditMode, {required void Function(String?) onSaved} ) {
  return DataCell(
    
    isEditMode
        ? TextFormField(
            initialValue: name,
            onSaved: onSaved ,
            style: const TextStyle(fontSize: 14),
          )
        : Text(name),
  );
}
 