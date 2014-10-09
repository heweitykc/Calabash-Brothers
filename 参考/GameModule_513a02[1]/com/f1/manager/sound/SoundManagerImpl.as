package com.f1.manager.sound
{
    import com.f1.*;
    import com.f1.manager.sound.*;
    import com.f1.utils.*;
    import com.greensock.plugins.*;
    import flash.utils.*;

    public class SoundManagerImpl extends Object implements ISoundManager
    {
        private var keyDic:Dictionary;
        private var soundObjectDic:Dictionary;
        private var backGroundKey:String = "";
        private var backGroundSilenceFlag:Boolean = false;
        private var otherSilenceFlag:Boolean = false;
        private static var _delay:int = 30;
        private static var instance:ISoundManager;

        public function SoundManagerImpl()
        {
            this.keyDic = new Dictionary();
            this.soundObjectDic = new Dictionary();
            if (instance)
            {
                throw new Error("Instance already exists.");
            }
            return;
        }// end function

        public function playBackGroundSound(param1:String, param2:Boolean, param3:Boolean, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number) : Boolean
        {
            var _loc_11:* = null;
            var _loc_12:* = null;
            if (this.backGroundSilenceFlag)
            {
                param5 = 0;
                param6 = 0;
                param8 = 0;
                param9 = 0;
            }
            if (this.backGroundKey != null && this.backGroundKey != "" && this.backGroundKey != param1)
            {
                _loc_11 = this.soundObjectDic[this.backGroundKey];
                if (_loc_11 != null)
                {
                    _loc_11.stop(param4, param5, param6);
                }
            }
            var _loc_10:* = this.keyDic[param1];
            if (this.keyDic[param1] == null || _loc_10 == "")
            {
                return false;
            }
            _loc_10 = LoadHelper.getTrueURL(_loc_10);
            _loc_12 = this.soundObjectDic[param1];
            if (_loc_12 == null)
            {
                _loc_12 = new SoundObject(param1, _loc_10);
                this.soundObjectDic[param1] = _loc_12;
            }
            _loc_12.play(true, param2, param1 == this.backGroundKey ? (false) : (param3), null, param7, param8, param1 == this.backGroundKey ? (0) : (param9), param1 == this.backGroundKey ? (0) : (param6));
            this.backGroundKey = param1;
            return true;
        }// end function

        public function stopBackGroundSound(param1:Number = -1, param2:Number = 0, param3:Number = 3) : void
        {
            var _loc_4:* = this.soundObjectDic[this.backGroundKey];
            if (this.soundObjectDic[this.backGroundKey] == null)
            {
                Log.log("该声音没有被初始化: " + this.backGroundKey);
            }
            else
            {
                _loc_4.stop(param1, param2, param3);
            }
            return;
        }// end function

        public function play(param1:String, param2:Boolean, param3:Boolean, param4:Function, param5:Number, param6:Number, param7:Number, param8:int) : Boolean
        {
            var _loc_10:* = null;
            if (this.otherSilenceFlag)
            {
                param6 = 0;
                param7 = 0;
            }
            var _loc_9:* = this.keyDic[param1];
            if (this.keyDic[param1] == null || _loc_9 == "")
            {
                return false;
            }
            _loc_9 = LoadHelper.getTrueURL(_loc_9);
            _loc_10 = this.soundObjectDic[param1];
            if (_loc_10 == null)
            {
                if (!_loc_9)
                {
                    Log.log("error:声音" + param1 + "，URL为空");
                    return false;
                }
                _loc_10 = new SoundObject(param1, _loc_9);
                this.soundObjectDic[param1] = _loc_10;
                _loc_10.play(true, param2, param3, param4, param5, param6, param7, 0, param8);
            }
            else
            {
                _loc_10.play(false, param2, param3, param4, param5, param6, param7, 0, param8);
            }
            return true;
        }// end function

        public function stop(param1:String) : void
        {
            if (param1 == null)
            {
                return;
            }
            var _loc_2:* = this.soundObjectDic[param1];
            if (_loc_2 == null)
            {
                Log.log("该声音没有被初始化: " + param1);
            }
            else
            {
                _loc_2.stop();
            }
            return;
        }// end function

        public function stopALL() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for (_loc_2 in this.soundObjectDic)
            {
                
                _loc_1 = _loc_4[_loc_2];
                if (_loc_1 == null)
                {
                    Log.log("该声音没有被初始化: " + _loc_2);
                    continue;
                }
                _loc_1.stop();
            }
            return;
        }// end function

        public function setSilence(param1:Boolean = true, param2:String = "") : void
        {
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            switch(param2)
            {
                case SoundManager.SILENCE_ALL:
                {
                    this.backGroundSilenceFlag = param1;
                    this.otherSilenceFlag = param1;
                    for (_loc_4 in this.soundObjectDic)
                    {
                        
                        this.setVolume(param1 ? (0) : (1), _loc_4);
                    }
                    break;
                }
                case SoundManager.SILENCE_BACK_GROUND_SOUND:
                {
                    this.backGroundSilenceFlag = param1;
                    this.setVolume(param1 ? (0) : (1), this.backGroundKey);
                    break;
                }
                case SoundManager.SILENCE_OTHER:
                {
                    this.otherSilenceFlag = param1;
                    for (_loc_4 in this.soundObjectDic)
                    {
                        
                        if (this.backGroundKey != String(_loc_4))
                        {
                            this.setVolume(param1 ? (0) : (1), _loc_4);
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function setVolume(param1:Number, param2:String) : void
        {
            var _loc_3:* = this.soundObjectDic[param2];
            if (_loc_3 != null)
            {
                _loc_3.setVolume(param1);
            }
            return;
        }// end function

        public function getSoundObjectByKey(param1:String) : SoundObject
        {
            return this.soundObjectDic[param1];
        }// end function

        public function addSoundKeyAndUrl(param1:String, param2:String) : void
        {
            this.keyDic[param1] = param2;
            return;
        }// end function

        public static function getInstance() : ISoundManager
        {
            if (!instance)
            {
                instance = new SoundManagerImpl;
                TweenPlugin.activate([VolumePlugin]);
            }
            return instance;
        }// end function

    }
}
