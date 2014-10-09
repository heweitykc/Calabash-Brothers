package com.staticdata
{

    public class PlayerConfig extends Object
    {
        public var value:int;
        private static var _instance:PlayerConfig;
        public static const PHONE_VERIFY_CLICK:int = 0;
        public static const SOUND_SETTING:int = 2;

        public function PlayerConfig()
        {
            return;
        }// end function

        public function getValue(param1:int) : int
        {
            if (param1 == SOUND_SETTING)
            {
                return this.getSoundSetting();
            }
            return (1 << param1 & this.value) == 0 ? (0) : (1);
        }// end function

        public function setValue(param1:int, param2:int) : int
        {
            if (param1 == SOUND_SETTING)
            {
                return this.setSoundSetting(param2);
            }
            this.value = (this.value & ~(1 << param1)) + (param2 << param1);
            return this.value;
        }// end function

        private function getSoundSetting() : int
        {
            return (3 << 1 & this.value) >> 1;
        }// end function

        private function setSoundSetting(param1:int) : int
        {
            this.value = this.value;
            this.value = (this.value & ~6) + (param1 << 1);
            return this.value;
        }// end function

        public static function getInstance() : PlayerConfig
        {
            if (!_instance)
            {
                _instance = new PlayerConfig;
            }
            return _instance;
        }// end function

    }
}
