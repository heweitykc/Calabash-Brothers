package com.game.autopk
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.model.*;
    import com.game.backpack.model.*;
    import com.game.map.view.*;
    import com.game.role.*;
    import com.staticdata.*;

    public class AutoFightManager extends Object
    {
        private var _fightLogic:AutoFightLogic;
        private var _gatherLogic:GatherLogic;
        private var _type:int;
        private static var _instance:AutoFightManager;
        public static var NONE_TYPE:int = 0;
        public static var FIGHT_TYPE:int = 1;
        public static var TASK_TYPE:int = 2;

        public function AutoFightManager()
        {
            this._fightLogic = new AutoFightLogic();
            this._gatherLogic = new GatherLogic();
            return;
        }// end function

        public function setMounsterType(param1:Vector.<int>) : void
        {
            AutoFightModel.mounsterType = param1;
            return;
        }// end function

        public function get fightLogic() : AutoFightLogic
        {
            return this._fightLogic;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set force(param1:Boolean) : void
        {
            this._fightLogic.force = param1;
            return;
        }// end function

        public function autoFight(param1:Boolean, param2:Boolean = false) : void
        {
            if (param1 && param2 && BackpackObj.getInstance().isFull())
            {
                Global.popManager.addedToStatus(LanguageCfgObj.getInstance().getByIndex("10299"));
                return;
            }
            this._type = param1 ? (FIGHT_TYPE) : (NONE_TYPE);
            if (param1)
            {
                if (param2)
                {
                    this._gatherLogic.gather(true);
                    this._fightLogic.force = true;
                    this._fightLogic.fight(false);
                }
                else
                {
                    this._gatherLogic.gather(false);
                    this._fightLogic.fight(true);
                }
            }
            else
            {
                this._fightLogic.fight(param1);
                this._gatherLogic.gather(param1);
            }
            return;
        }// end function

        public function taskFight(param1:Boolean, param2:Boolean = false) : void
        {
            Player.state = State.NONE;
            if (param1)
            {
                AutoFightController.getInstance().openAutoFight(param2);
            }
            else
            {
                AutoFightController.getInstance().closeAutoFight();
            }
            this._type = param1 ? (TASK_TYPE) : (NONE_TYPE);
            return;
        }// end function

        public function isAutoFighting() : Boolean
        {
            if (this._fightLogic && this._fightLogic.fighting)
            {
                return true;
            }
            if (this._gatherLogic && this._gatherLogic.fighting)
            {
                return true;
            }
            return false;
        }// end function

        public function pickRareItem(param1:DropIcon) : void
        {
            this._fightLogic.pickRare(param1);
            return;
        }// end function

        public static function getInstance() : AutoFightManager
        {
            var _loc_1:* = _instance || new AutoFightManager;
            _instance = _instance || new AutoFightManager;
            return _loc_1;
        }// end function

    }
}
