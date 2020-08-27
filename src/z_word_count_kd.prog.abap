*&---------------------------------------------------------------------*
*& Report z_word_count_kd
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_word_count_kd.

SELECTION-SCREEN BEGIN OF SCREEN 200 TITLE title AS WINDOW.
  PARAMETERS: iv_text TYPE string.
SELECTION-SCREEN END OF SCREEN 200.

CALL SELECTION-SCREEN 200.
