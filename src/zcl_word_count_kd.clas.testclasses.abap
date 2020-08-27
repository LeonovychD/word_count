CLASS zcl_word_count_kd_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA cut TYPE REF TO zcl_word_count_kd.
    TYPES t_itab TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    DATA itab TYPE t_itab.

    METHODS:
      setup,
      test_two_words FOR TESTING RAISING cx_static_check,
      test_no_words FOR TESTING RAISING cx_static_check,
      test_with_stop_words FOR TESTING RAISING cx_static_check,
      test_with_only_stop_words FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS zcl_word_count_kd_test IMPLEMENTATION.



  METHOD setup.
    cut = NEW zcl_word_count_kd(  ).
    itab = VALUE #( ( `a` ) ( `the` ) ( `an` ) ).
  ENDMETHOD.

  METHOD test_two_words.
    cl_abap_unit_assert=>assert_equals( msg = 'Count two words' exp = 2 act = cut->counter( iv_itab = itab iv_text = 'first sentence' ) ).
  ENDMETHOD.

  METHOD test_no_words.
    cl_abap_unit_assert=>assert_equals( msg = 'No words entered' exp = 0 act = cut->counter( iv_itab = itab iv_text = '' ) ).
  ENDMETHOD.

  METHOD test_with_stop_words.
    cl_abap_unit_assert=>assert_equals( msg = 'remove stop words' exp = 5 act = cut->counter( iv_itab = itab iv_text = 'Had an umbrella with a different color'  ) ).
  ENDMETHOD.

  METHOD test_with_only_stop_words.
    cl_abap_unit_assert=>assert_equals( msg = 'one stop words in a sentence' exp = 0 act = cut->counter( iv_itab = itab iv_text = 'an a the'  ) ).
  ENDMETHOD.

ENDCLASS.
