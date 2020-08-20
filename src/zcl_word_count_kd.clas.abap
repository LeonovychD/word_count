CLASS zcl_word_count_kd DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS counter
      IMPORTING
        iv_text         TYPE string
      RETURNING
        value(rv_num_of_words) TYPE integer.
  PROTECTED SECTION.
  PRIVATE SECTION.
  DATA value TYPE i.
ENDCLASS.



CLASS zcl_word_count_kd IMPLEMENTATION.
  METHOD counter.
   SPLIT iv_text AT space INTO TABLE DATA(itab).
   rv_num_of_words = lines( itab ).
  ENDMETHOD.

ENDCLASS.
