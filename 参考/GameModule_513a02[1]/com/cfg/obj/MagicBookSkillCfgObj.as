package com.cfg.obj
{
    import com.f1.manager.*;
    import com.game.magicbook.bean.*;
    import com.model.vo.*;

    public class MagicBookSkillCfgObj extends Object
    {
        private var _map:Object;
        private static var _instance:MagicBookSkillCfgObj;

        public function MagicBookSkillCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_magicbook_skill");
            return;
        }// end function

        public function getMagicSkillInfo(param1:int) : MagicBookSkillInfo
        {
            var _loc_2:* = new MagicBookSkillInfo();
            _loc_2.parse(this._map[param1]);
            return _loc_2;
        }// end function

        public function getMagicSkillInfoByServer(param1:MagicSkillInfo) : MagicBookSkillInfo
        {
            var _loc_2:* = new MagicBookSkillInfo();
            _loc_2.parse(this._map[param1.skillModelId]);
            return _loc_2;
        }// end function

        public static function getInstance() : MagicBookSkillCfgObj
        {
            if (_instance == null)
            {
                _instance = new MagicBookSkillCfgObj;
            }
            return _instance;
        }// end function

    }
}
