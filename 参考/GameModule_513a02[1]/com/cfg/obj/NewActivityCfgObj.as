package com.cfg.obj
{
    import com.f1.manager.*;

    public class NewActivityCfgObj extends Object
    {
        private var _actObj:Object;
        private static var instance:NewActivityCfgObj;

        public function NewActivityCfgObj()
        {
            this._actObj = CfgManager.getInstance().getMap("q_new_activity");
            return;
        }// end function

        public function getActivityCfgByActivityId(param1:int) : Object
        {
            return this._actObj[param1];
        }// end function

        public static function getInstance() : NewActivityCfgObj
        {
            if (instance == null)
            {
                instance = new NewActivityCfgObj;
            }
            return instance;
        }// end function

    }
}
