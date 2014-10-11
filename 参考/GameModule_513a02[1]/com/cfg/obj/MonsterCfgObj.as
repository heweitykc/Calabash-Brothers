package com.cfg.obj
{
    import com.cfg.vo.*;
    import com.f1.manager.*;
    import com.model.vo.*;
    import flash.utils.*;

    public class MonsterCfgObj extends Object
    {
        private var _map:Object;
        private var monsterSpeakDic:Dictionary;
        private static var instance:MonsterCfgObj;

        public function MonsterCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("monster");
            this.initMonsterSpeakData();
            return;
        }// end function

        private function initMonsterSpeakData() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this.monsterSpeakDic = new Dictionary();
            for each (_loc_1 in this._map)
            {
                
                _loc_6 = _loc_1.q_say_condition;
                if (!_loc_6 || _loc_6.length < 1)
                {
                    continue;
                }
                this.monsterSpeakDic[_loc_1.q_id] = [];
                _loc_2 = String(_loc_6).split(";");
                for each (_loc_3 in _loc_2)
                {
                    
                    _loc_4 = _loc_3.split("_");
                    _loc_5 = new CutePetSpeakInfo();
                    _loc_5.content = _loc_4[1];
                    _loc_5.percent = _loc_4[0];
                    this.monsterSpeakDic[_loc_1.q_id].push(_loc_5);
                }
            }
            return;
        }// end function

        public function getMonsterCfg(param1:uint) : Monster
        {
            var _loc_2:* = new Monster();
            _loc_2.parse(this._map[param1]);
            return _loc_2;
        }// end function

        public function getMonsterObjCfg(param1:uint) : Object
        {
            return this._map[param1];
        }// end function

        public function getMonsterSpeakByMonId(param1:uint) : Array
        {
            return this.monsterSpeakDic[param1];
        }// end function

        public static function getInstance() : MonsterCfgObj
        {
            if (instance == null)
            {
                instance = new MonsterCfgObj;
            }
            return instance;
        }// end function

    }
}
