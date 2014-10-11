package com.game.zones.view.bosshome.cfg
{
    import com.f1.manager.*;

    public class BossHomeCfgObj extends Object
    {
        private var _map:Object;
        private static var _instance:BossHomeCfgObj;

        public function BossHomeCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("boss_home");
            return;
        }// end function

        public function getAngelByModelId(param1:int) : int
        {
            if (!this._map[param1])
            {
                return 0;
            }
            return this._map[param1].q_anger;
        }// end function

        public static function getInstance() : BossHomeCfgObj
        {
            if (!_instance)
            {
                _instance = new BossHomeCfgObj;
            }
            return _instance;
        }// end function

    }
}
