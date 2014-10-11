package com.game.hotkeyguide.cfg
{
    import com.f1.manager.*;

    public class HotkeyGuideCfgObj extends Object
    {
        private var map:Object;
        private static var instance:HotkeyGuideCfgObj;

        public function HotkeyGuideCfgObj()
        {
            this.map = CfgManager.getInstance().getMap("q_hotkey_guide");
            if (this.map == null)
            {
                this.map = new Object();
            }
            return;
        }// end function

        public function getHotkeyGuideCfg(param1:uint, param2:uint) : HotkeyGuideCfg
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_3:* = this.map[param1 + "_" + param2];
            if (!_loc_3)
            {
                _loc_4 = HotkeyGuideTaskState.getSuperStates(param2);
                if (_loc_4)
                {
                    for each (_loc_5 in _loc_4)
                    {
                        
                        _loc_3 = this.map[param1 + "_" + _loc_5];
                        if (_loc_3)
                        {
                            break;
                        }
                    }
                }
            }
            return _loc_3 ? (new HotkeyGuideCfg(_loc_3)) : (null);
        }// end function

        public static function getInstance() : HotkeyGuideCfgObj
        {
            var _loc_1:* = new HotkeyGuideCfgObj;
            instance = new HotkeyGuideCfgObj;
            return instance || _loc_1;
        }// end function

    }
}
