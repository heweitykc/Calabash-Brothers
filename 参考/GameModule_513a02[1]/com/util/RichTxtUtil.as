package com.util
{
    import com.f1.utils.*;
    import com.model.vo.*;

    public class RichTxtUtil extends Object
    {

        public function RichTxtUtil()
        {
            return;
        }// end function

        public static function makeTxt(param1:String) : String
        {
            var _loc_2:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_3:* = "";
            var _loc_4:* = new RegExp("<(S*?)[^>]*>.*?|<.*? />", "gi");
            var _loc_5:* = [];
            do
            {
                
                _loc_13 = {};
                _loc_13.index = _loc_6.index;
                _loc_13.lastIndex = _loc_4.lastIndex;
                _loc_13.content = _loc_6[0];
                _loc_5.push(_loc_13);
                var _loc_14:* = _loc_4.exec(param1);
                _loc_6 = _loc_4.exec(param1);
            }while (_loc_14 != null)
            _loc_7 = 0;
            _loc_8 = 0;
            while (_loc_8 < _loc_5.length)
            {
                
                _loc_9 = _loc_7;
                while (_loc_9 < _loc_5[_loc_8].index)
                {
                    
                    _loc_10 = param1.charAt(_loc_9);
                    if (_loc_10 == "#")
                    {
                        _loc_11 = param1.substr((_loc_9 + 1), 2);
                        _loc_12 = int(_loc_11);
                        if (_loc_12 > 0 && _loc_12 <= ChatInfo.FACELENGTH)
                        {
                            if (_loc_12.toString().length < 2)
                            {
                                if (_loc_12 == int(_loc_11.charAt(0)))
                                {
                                    _loc_9 = _loc_9 + 1;
                                }
                                else
                                {
                                    _loc_9 = _loc_9 + 2;
                                }
                            }
                            else
                            {
                                _loc_9 = _loc_9 + 2;
                            }
                            ;
                        }
                        else
                        {
                            _loc_11 = param1.substr((_loc_9 + 1), 1);
                            _loc_12 = int(_loc_11);
                            if (_loc_12 > 0 && _loc_12 <= ChatInfo.FACELENGTH)
                            {
                                _loc_9 = _loc_9 + 1;
                                ;
                            }
                        }
                    }
                    _loc_3 = _loc_3 + _loc_10;
                    _loc_9++;
                }
                _loc_3 = _loc_3 + _loc_5[_loc_8].content;
                _loc_7 = _loc_5[_loc_8].lastIndex;
                _loc_8++;
            }
            _loc_8 = _loc_7;
            while (_loc_8 < param1.length)
            {
                
                _loc_10 = param1.charAt(_loc_8);
                if (_loc_10 == "#")
                {
                    _loc_11 = param1.substr((_loc_8 + 1), 2);
                    _loc_12 = int(_loc_11);
                    if (_loc_12 > 0 && _loc_12 <= ChatInfo.FACELENGTH)
                    {
                        if (_loc_11.length < 2)
                        {
                            _loc_11 = ToolKit.add0(_loc_12, 2);
                            _loc_8 = _loc_8 + 1;
                        }
                        else
                        {
                            _loc_8 = _loc_8 + 2;
                        }
                        ;
                    }
                }
                _loc_3 = _loc_3 + _loc_10;
                _loc_8++;
            }
            _loc_2 = _loc_3.split(/\f/).join("");
            return _loc_2;
        }// end function

        public static function countFace(param1:String) : int
        {
            var _loc_2:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_3:* = "";
            var _loc_4:* = new RegExp("<(S*?)[^>]*>.*?|<.*? />", "gi");
            var _loc_5:* = [];
            do
            {
                
                _loc_14 = {};
                _loc_14.index = _loc_6.index;
                _loc_14.lastIndex = _loc_4.lastIndex;
                _loc_14.content = _loc_6[0];
                _loc_5.push(_loc_14);
                var _loc_15:* = _loc_4.exec(param1);
                _loc_6 = _loc_4.exec(param1);
            }while (_loc_15 != null)
            _loc_7 = 0;
            _loc_8 = 0;
            while (_loc_8 < _loc_5.length)
            {
                
                _loc_9 = _loc_7;
                while (_loc_9 < _loc_5[_loc_8].index)
                {
                    
                    _loc_10 = param1.charAt(_loc_9);
                    if (_loc_10 == "#")
                    {
                        _loc_11 = param1.substr((_loc_9 + 1), 2);
                        _loc_12 = int(_loc_11);
                        if (_loc_12 > 0 && _loc_12 <= ChatInfo.FACELENGTH)
                        {
                            if (_loc_12.toString().length < 2)
                            {
                                if (_loc_12 == int(_loc_11.charAt(0)))
                                {
                                    _loc_13++;
                                }
                                else
                                {
                                    _loc_13++;
                                }
                            }
                            else
                            {
                                _loc_13++;
                            }
                            ;
                        }
                        else
                        {
                            _loc_11 = param1.substr((_loc_9 + 1), 1);
                            _loc_12 = int(_loc_11);
                            if (_loc_12 > 0 && _loc_12 <= ChatInfo.FACELENGTH)
                            {
                                _loc_13++;
                                ;
                            }
                        }
                    }
                    _loc_9++;
                }
                _loc_7 = _loc_5[_loc_8].lastIndex;
                _loc_8++;
            }
            return _loc_13;
        }// end function

    }
}
