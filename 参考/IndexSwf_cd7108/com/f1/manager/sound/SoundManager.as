package com.f1.manager.sound
{

    public class SoundManager extends Object
    {
        private static var isAllStop:Boolean;
        private static var _impl:ISoundManager;
        public static var volume:Number = 1;
        public static var onlyPlayKeySound:Boolean = false;
        public static const SILENCE_ALL:String = "all";
        public static const SILENCE_BACK_GROUND_SOUND:String = "backGroundSound";
        public static const SILENCE_OTHER:String = "other";

        public function SoundManager()
        {
            return;
        }// end function

        private static function get impl() : ISoundManager
        {
            if (!_impl)
            {
                _impl = SoundManagerImpl.getInstance();
            }
            return _impl;
        }// end function

        public static function playBackGroundSound(param1:String, param2:Boolean = true, param3:Boolean = true, param4:Number = -1, param5:Number = 0, param6:Number = 3, param7:Number = 0, param8:Number = 1, param9:Number = 3) : Boolean
        {
            if (!isAllStop)
            {
                return impl.playBackGroundSound(param1, param2, param3, param4, param5, param6, param7, param8, param9);
            }
            return true;
        }// end function

        public static function stopBackGroundSound(param1:Number = -1, param2:Number = 0, param3:Number = 3) : void
        {
            impl.stopBackGroundSound(param1, param2, param3);
            return;
        }// end function

        public static function play(param1:String, param2:Boolean = false, param3:Boolean = true, param4:Function = null, param5:Number = 0, param6:Number = 0.5, param7:Number = 0, param8:int = 0) : Boolean
        {
            return impl.play(param1, param2, param3, param4, param5, param6, param7, param8);
        }// end function

        public static function playDelay(param1:String, param2:Boolean = true, param3:int = 3) : void
        {
            return;
        }// end function

        public static function stop(param1:String) : void
        {
            impl.stop(param1);
            return;
        }// end function

        public static function setSilence(param1:Boolean = true, param2:String = "all") : void
        {
            impl.setSilence(param1, param2);
            return;
        }// end function

        public static function setVolume(param1:Number, param2:String) : void
        {
            impl.setVolume(param1, param2);
            return;
        }// end function

        public static function stopAll() : void
        {
            impl.stopALL();
            return;
        }// end function

        public static function getSoundObjectByKey(param1:String) : SoundObject
        {
            return impl.getSoundObjectByKey(param1);
        }// end function

        public static function setXML(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_2 in param1.sound)
            {
                
                _loc_3 = String(_loc_2.@key);
                _loc_4 = String(_loc_2.@url);
                impl.addSoundKeyAndUrl(_loc_3, _loc_4);
            }
            return;
        }// end function

        public static function setMap(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_2 in param1)
            {
                
                _loc_3 = _loc_2.key;
                _loc_4 = _loc_2.url;
                impl.addSoundKeyAndUrl(_loc_3, _loc_4);
            }
            return;
        }// end function

        public static function addKeyValueMap(param1:String, param2:String) : void
        {
            impl.addSoundKeyAndUrl(param1, param2);
            return;
        }// end function

        public static function setBin(param1:Array) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                impl.addSoundKeyAndUrl(_loc_2.key, _loc_2.url);
            }
            return;
        }// end function

    }
}
