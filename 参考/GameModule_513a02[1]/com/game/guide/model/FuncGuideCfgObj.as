package com.game.guide.model
{
    import com.f1.manager.*;

    public class FuncGuideCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:FuncGuideCfgObj;

        public function FuncGuideCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_resource_remind");
            return;
        }// end function

        public function getFunGuide(param1:int) : FunGuideCfg
        {
            var _loc_2:* = new FunGuideCfg();
            _loc_2.prase(this._map[param1]);
            return _loc_2;
        }// end function

        public static function getInstance() : FuncGuideCfgObj
        {
            if (instance == null)
            {
                instance = new FuncGuideCfgObj;
            }
            return instance;
        }// end function

    }
}
