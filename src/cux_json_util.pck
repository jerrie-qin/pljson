CREATE OR REPLACE PACKAGE APPS.cux_json_util AS
  /*==================================================
  Copyright (C) Hand Enterprise Solutions Co.,Ltd.
             AllRights Reserved
  ==================================================*/
  /*==================================================
  Program Name:
      CUX_JSON_UTIL
  Description:
      This program provide public API to perform:
           
  History: 
      1.00  2016-04-09  101002814  Creation
  ==================================================*/


  /*==================================================
  Procedure Name :
      is_json
  Description:
      This procedure perform to check whether varchar can be convert to json
  Argument:
      p_init_msg_list : Whether initialize message list
      x_return_status : API return  S success / E error / U unexpected error
      x_msg_count     : return message list count
      x_msg_data      : return message data when count=1, others null
      varchartype    : 
  History: 
      1.00 2016-04-09  101002814  Creation
  ==================================================*/
  FUNCTION is_json(vartype IN VARCHAR2) RETURN BOOLEAN;

  /*==================================================
  Procedure Name :
      is_json
  Description:
      This procedure perform to check whether clob can be convert to json
  Argument:
      p_init_msg_list : Whether initialize message list
      x_return_status : API return  S success / E error / U unexpected error
      x_msg_count     : return message list count
      x_msg_data      : return message data when count=1, others null
      clobtype    : 
  History: 
      1.00 2016-04-09  101002814  Creation
  ==================================================*/
  FUNCTION is_json(clobtype IN CLOB) RETURN BOOLEAN;

  /*==================================================
  Procedure Name :
      is_json_list
  Description:
      This procedure perform to check whether varchar can be convert to json
  Argument:
      p_init_msg_list : Whether initialize message list
      x_return_status : API return  S success / E error / U unexpected error
      x_msg_count     : return message list count
      x_msg_data      : return message data when count=1, others null
      varchartype    : 
  History: 
      1.00 2016-04-09  101002814  Creation
  ==================================================*/
  FUNCTION is_json_list(vartype IN VARCHAR2) RETURN BOOLEAN;

  /*==================================================
  Procedure Name :
      is_json_list
  Description:
      This procedure perform to check whether clob can be convert to json
  Argument:
      p_init_msg_list : Whether initialize message list
      x_return_status : API return  S success / E error / U unexpected error
      x_msg_count     : return message list count
      x_msg_data      : return message data when count=1, others null
      clobtype    : 
  History: 
      1.00 2016-04-09  101002814  Creation
  ==================================================*/
  FUNCTION is_json_list(clobtype IN CLOB) RETURN BOOLEAN;

  /*==================================================
  Procedure Name :
      ascii_to_str
  Description:
      中文ASCII码转中文汉字
  Argument:
      p_string : 字符串
     
  History: 
      1.00 2016-04-09  101002814  Creation
  ==================================================*/
  FUNCTION ascii_to_str(p_string IN VARCHAR2) RETURN VARCHAR2;

  /*==================================================
  Procedure Name :
      str_to_ascii
  Description:
      中文汉字转unicode码
  Argument:
      p_string : 字符串
     
  History: 
      1.00 2016-04-09  101002814  Creation
  ==================================================*/
  FUNCTION str_to_unicode(p_string IN VARCHAR2) RETURN VARCHAR2;

  /*==================================================
  Procedure Name :
      format_clob
  Description:
      格式化clob中汉字
      将汉字转化为unicode编码
  Argument:
      p_src_clob : 
     
  History: 
      1.00 2016-04-09  101002814  Creation
  ==================================================*/
  FUNCTION format_clob(p_src_clob IN CLOB) RETURN CLOB;

  /*==================================================
  Procedure Name :
      truefalse_to_YN
  Description:
      将ture/false 转化为Y/N编码
  Argument:
      p_string : 
     
  History: 
      1.00 2016-04-09  101002814  Creation
  ==================================================*/
  FUNCTION truefalse_to_yn(p_string IN VARCHAR2) RETURN VARCHAR2;
END cux_json_util;
/
CREATE OR REPLACE PACKAGE BODY APPS.cux_json_util AS
  /*==================================================
  Copyright (C) Hand Enterprise Solutions Co.,Ltd.
             AllRights Reserved
  ==================================================*/
  /*==================================================
  Program Name:
      CUX_JSON_UTIL
  Description:
      This program provide public API to perform:
           
  History: 
      1.00  2016-04-09  101002814  Creation
  ==================================================*/


  FUNCTION is_json(vartype IN VARCHAR2) RETURN BOOLEAN IS
    lj_json json;
  BEGIN
    lj_json := json(vartype);
  
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END is_json;

  FUNCTION is_json(clobtype IN CLOB) RETURN BOOLEAN IS
    lj_json json;
  BEGIN
    lj_json := json(clobtype);
  
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END is_json;

  FUNCTION is_json_list(vartype IN VARCHAR2) RETURN BOOLEAN IS
    lj_json_list json_list;
  BEGIN
    lj_json_list := json_list(vartype);
  
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END is_json_list;

  FUNCTION is_json_list(clobtype IN CLOB) RETURN BOOLEAN IS
    lj_json_list json_list;
  BEGIN
    lj_json_list := json_list(clobtype);
  
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END is_json_list;

  FUNCTION truefalse_to_yn(p_string IN VARCHAR2) RETURN VARCHAR2 IS
    o_string VARCHAR2(4000);
  BEGIN
    IF upper(p_string) = 'TRUE' or upper(p_string) = 'YES'  THEN
      o_string := 'Y';
    ELSIF upper(p_string) = 'FALSE' or upper(p_string) = 'NO'  THEN
      o_string := 'N';
    ELSE
      o_string := p_string;
    END IF;
    RETURN(o_string);
  END truefalse_to_yn;

  FUNCTION ascii_to_str(p_string IN VARCHAR2) RETURN VARCHAR2 IS
  
    o_string VARCHAR2(5000);
    p_yn_1   VARCHAR2(1) := 'N';
    p_yn_2   VARCHAR2(1) := 'N';
    p_yn_3   VARCHAR2(1) := 'N';
  
  BEGIN
    o_string := p_string;
   
    IF p_string LIKE '%/%' THEN
      o_string := REPLACE(o_string
                         ,'/'
                         ,'<$>');
      p_yn_1   := 'Y';
    END IF;
  
    IF o_string LIKE '%\u%' THEN
      o_string := REPLACE(o_string
                         ,'\u'
                         ,'<@');
      p_yn_2   := 'Y';
    END IF;
    IF o_string LIKE '%\%' THEN
      o_string := REPLACE(o_string
                         ,'\'
                         ,'<?>');
      p_yn_3   := 'Y';
    END IF;
    IF p_yn_2 = 'Y' THEN
      o_string := REPLACE(o_string
                         ,'<@'
                         ,'\u');
    END IF;
  
    o_string := truefalse_to_yn(unistr(REPLACE(o_string
                                              ,'\u'
                                              ,'\')));
    IF p_yn_3 = 'Y' THEN
      o_string := REPLACE(o_string
                         ,'<?>'
                         ,'\');
    END IF;
    IF p_yn_1 = 'Y' THEN
      o_string := REPLACE(o_string
                         ,'<$>'
                         ,'/');
    END IF;
    RETURN(o_string);
  END ascii_to_str;

  FUNCTION str_to_unicode(p_string IN VARCHAR2) RETURN VARCHAR2 IS
    l_ascii_temp VARCHAR2(32367);
  BEGIN
    l_ascii_temp := REPLACE(p_string
                           ,'\'
                           ,'^*');
    l_ascii_temp := asciistr(l_ascii_temp);
    l_ascii_temp := REPLACE(l_ascii_temp
                           ,'\'
                           ,'$@$');
    l_ascii_temp := REPLACE(l_ascii_temp
                           ,'^*'
                           ,'\');
    RETURN l_ascii_temp;

  END str_to_unicode;

  FUNCTION format_clob(p_src_clob IN CLOB) RETURN CLOB IS
    l_des_clob CLOB;
    ln_length  NUMBER;
    amount     NUMBER := 1024;
    offset     NUMBER := 1;
    buffer     VARCHAR2(32767);
  BEGIN
    dbms_lob.createtemporary(l_des_clob
                            ,TRUE);
  
    ln_length := dbms_lob.getlength(p_src_clob);
  
    WHILE offset <= ln_length
    LOOP
      dbms_lob.read(p_src_clob
                   ,amount
                   ,offset
                   ,buffer); --读取数据到缓冲区   
    
      offset := offset + amount;
    
      dbms_lob.append(l_des_clob
                     ,cux_json_util.str_to_unicode(buffer));
    END LOOP;
  
    RETURN l_des_clob;
  END format_clob;

END cux_json_util;
/
