package com.game.dragonking.model
{

    public class DragonKingModel extends Object
    {
        private var _curPhase:int;
        private const MAX_ROUND:int = 7;
        public var skillboxid:int;
        public const SKILL_ARRAY:Array;
        private static var _inst:DragonKingModel;

        public function DragonKingModel()
        {
            this.SKILL_ARRAY = [10223, 10222, 10224];
            return;
        }// end function

        public function get curPhase() : int
        {
            return this._curPhase;
        }// end function

        public function set curPhase(param1:int) : void
        {
            if (param1 > this.MAX_ROUND)
            {
                param1 = this.MAX_ROUND;
            }
            this._curPhase = param1;
            return;
        }// end function

        public static function getInstance() : DragonKingModel
        {
            var _loc_1:* = new DragonKingModel;
            _inst = new DragonKingModel;
            return _inst || _loc_1;
        }// end function

    }
}
