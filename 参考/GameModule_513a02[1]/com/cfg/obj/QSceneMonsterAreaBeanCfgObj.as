package com.cfg.obj
{
    import com.cfg.vo.*;
    import com.f1.manager.*;

    public class QSceneMonsterAreaBeanCfgObj extends Object
    {
        private var _map:Object;
        private static var _instance:QSceneMonsterAreaBeanCfgObj;

        public function QSceneMonsterAreaBeanCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("Q_scene_monster_areaBean");
            return;
        }// end function

        public function getMonsterAreaBeanById(param1:int) : QSceneMonsterAreaBean
        {
            var _loc_2:* = new QSceneMonsterAreaBean();
            _loc_2.parse(this._map[param1]);
            return _loc_2;
        }// end function

        public function getMonsterByModelIdAndMapId(param1:int, param2:int) : QSceneMonsterAreaBean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_3 in this._map)
            {
                
                if (_loc_3.q_mapid == param2 && _loc_3.q_monster_model == param1)
                {
                    _loc_4 = new QSceneMonsterAreaBean();
                    _loc_4.parse(_loc_3);
                    return _loc_4;
                }
            }
            return null;
        }// end function

        public static function getInstance() : QSceneMonsterAreaBeanCfgObj
        {
            if (!_instance)
            {
                _instance = new QSceneMonsterAreaBeanCfgObj;
            }
            return _instance;
        }// end function

    }
}
