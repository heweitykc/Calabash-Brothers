package com.cfg.obj
{
    import com.f1.manager.*;
    import com.model.vo.*;
    import flash.utils.*;

    public class SpeakCfgObj extends Object
    {
        private var _map:Object;
        private var _taskSpeakDic:Dictionary;
        private var _mapSpeakDic:Dictionary;
        private var _levelSpeakDic:Dictionary;
        private var _freeSpeakDic:Dictionary;
        private var _mapFreeSpeakTimeDic:Dictionary;
        private static var instance:SpeakCfgObj;

        public function SpeakCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_pet_bubble");
            this.initSpeak();
            return;
        }// end function

        private function initSpeak() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            this._taskSpeakDic = new Dictionary();
            this._mapSpeakDic = new Dictionary();
            this._levelSpeakDic = new Dictionary();
            this._freeSpeakDic = new Dictionary();
            this._mapFreeSpeakTimeDic = new Dictionary();
            var _loc_8:* = 0;
            for each (_loc_3 in this._map)
            {
                
                _loc_1 = [];
                _loc_10 = _loc_3.q_type.split("_");
                _loc_6 = _loc_3.q_word.split(";");
                _loc_8 = 0;
                _loc_9 = _loc_6.length;
                while (_loc_8 < _loc_9)
                {
                    
                    if (!_loc_6[_loc_8] || _loc_6[_loc_8] == "")
                    {
                    }
                    else
                    {
                        _loc_11 = _loc_6[_loc_8] as String;
                        _loc_11 = _loc_11.replace(/"/g, "");
                        _loc_7 = _loc_11.split("_");
                        _loc_4 = new CutePetSpeakInfo();
                        _loc_4.time = _loc_7[0];
                        _loc_4.content = _loc_7[1];
                        _loc_1.push(_loc_4);
                    }
                    _loc_8++;
                }
                if (_loc_10[0] == 1)
                {
                    _loc_2 = [];
                    if (_loc_3.q_say_condition && _loc_3.q_say_condition != "")
                    {
                        this._mapFreeSpeakTimeDic[_loc_10[1]] = _loc_3.q_tosay_timeinterval;
                        _loc_12 = _loc_3.q_say_condition.split(";");
                        for each (_loc_14 in _loc_12)
                        {
                            
                            _loc_14 = _loc_14.replace(/"/g, "");
                            _loc_13 = _loc_14.split("_");
                            _loc_5 = new CutePetSpeakInfo();
                            _loc_5.time = _loc_3.q_tosay_timeinterval;
                            _loc_5.percent = _loc_13[0];
                            _loc_5.content = _loc_13[1];
                            _loc_2.push(_loc_5);
                        }
                        this._freeSpeakDic[_loc_10[1]] = _loc_2;
                    }
                }
                switch(_loc_10[0])
                {
                    case "1":
                    {
                        this._mapSpeakDic[_loc_10[1]] = _loc_1;
                        break;
                    }
                    case "2":
                    {
                        this._taskSpeakDic[_loc_10[1]] = _loc_1;
                        break;
                    }
                    case "3":
                    {
                        this._levelSpeakDic[_loc_10[1]] = _loc_1;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function getSpeakArrByMap(param1:int) : Array
        {
            return this._mapSpeakDic[param1];
        }// end function

        public function getSpeakArrByTask(param1:int) : Array
        {
            return this._taskSpeakDic[param1];
        }// end function

        public function getSpeakArrByLevel(param1:int) : Array
        {
            return this._levelSpeakDic[param1];
        }// end function

        public function getFreeArrByMap(param1:int) : Array
        {
            return this._freeSpeakDic[param1];
        }// end function

        public function getFreeSpeakTimeByMapId(param1:int) : int
        {
            if (this._mapFreeSpeakTimeDic[param1])
            {
                return this._mapFreeSpeakTimeDic[param1];
            }
            return -1;
        }// end function

        public static function getInstance() : SpeakCfgObj
        {
            if (instance == null)
            {
                instance = new SpeakCfgObj;
            }
            return instance;
        }// end function

    }
}
