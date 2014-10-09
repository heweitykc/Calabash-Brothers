package com.game.remark.model
{

    public class RemarkModel extends Object
    {
        public var self:RoleAttributes;
        private static var _inst:RemarkModel;
        public static const REMARK:int = 1;
        public static const INTENSIFY:int = 2;

        public function RemarkModel()
        {
            this.self = new RoleAttributes();
            return;
        }// end function

        public static function getInstance() : RemarkModel
        {
            var _loc_1:* = new RemarkModel;
            _inst = new RemarkModel;
            return _inst || _loc_1;
        }// end function

    }
}
