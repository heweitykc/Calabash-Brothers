package com.game.clickstream
{
    import com.f1.manager.*;

    public class ClickStreamCfgObj extends Object
    {
        private static var instance:ClickStreamCfgObj;

        public function ClickStreamCfgObj()
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = CfgManager.getInstance().getMap("q_click_stream");
            if (_loc_1 == null)
            {
                _loc_1 = new Object();
            }
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = new ClickStreamCfg(_loc_2);
                _loc_4 = ClickStreamTriggerType.getInstance(_loc_3.q_trigger_type);
                if (_loc_4 != null)
                {
                    _loc_4.addCfg(_loc_3);
                }
            }
            return;
        }// end function

        public static function getInstance() : ClickStreamCfgObj
        {
            var _loc_1:* = new ClickStreamCfgObj;
            instance = new ClickStreamCfgObj;
            return instance || _loc_1;
        }// end function

    }
}
