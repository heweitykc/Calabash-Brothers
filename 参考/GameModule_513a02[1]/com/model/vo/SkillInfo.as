package com.model.vo
{
    import com.cfg.vo.*;
    import com.game.utils.*;
    import com.model.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.fightbase.view.*;
    import interfaces.role.*;

    public class SkillInfo extends Skill
    {
        public var skillFlyMC:FarAtkLight;
        public var skillId:long;
        public var shortcutId:long;
        public var skillLevel:int;
        public var showId:String;
        protected var _iconUrl:String;
        public var releaseURL:String;
        public var flyURL:String;
        public var hitURL:String;
        public var releaseGroundURL:String;
        public var hitGroundURL:String;
        private var _targetX:uint;
        public var targetY:uint;
        public var direct:int;
        private var _targetRole:IRole;
        private var _effectRoles:Array;
        public var q_passive_buff:Array;
        public static const SHAPE_POINT:uint = 1;
        public static const SHAPE_LINE:uint = 2;
        public static const SHAPE_CONE:uint = 3;
        public static const SHAPE_CIRCLE:uint = 4;
        public static const SHAPE_USER:uint = 5;
        public static const TARGET_TYPE_SELF:uint = 1;
        public static const TARGET_TYPE_FRIEND:uint = 2;
        public static const TARGET_TYPE_ENEMY:uint = 3;
        public static const TARGET_TYPE_CURRENT:uint = 4;
        public static const TARGET_TYPE_MOUSE:uint = 5;
        public static const TARGET_TYPE_OWNER:uint = 6;
        public static const SKILL_TYPE_FIRE:uint = 1;
        public static const SKILL_TYPE_CHONGFENG:uint = 2;
        public static const SKILL_TYPE_WIND:uint = 3;
        public static const SKILL_TYPE_ELECTRIC:uint = 4;
        public static const SKILL_TYPE_BOMP:uint = 5;
        public static const SKILL_TYPE_ADD:uint = 7;
        public static const POINT_TYPE_SELF:uint = 0;
        public static const POINT_TYPE_ROLE:uint = 1;
        public static const POINT_TYPE_MOUSE:uint = 2;
        public static const AREA_TARGET_SELF:uint = 1;
        public static const AREA_TARGET_GROUND:uint = 2;

        public function SkillInfo()
        {
            return;
        }// end function

        public function get targetX() : uint
        {
            return this._targetX;
        }// end function

        public function set targetX(param1:uint) : void
        {
            this._targetX = param1;
            return;
        }// end function

        public function get targetRole() : IRole
        {
            return this._targetRole;
        }// end function

        public function set targetRole(param1:IRole) : void
        {
            this._targetRole = param1;
            return;
        }// end function

        public function hasTargetRole() : Boolean
        {
            return this.targetRole != null;
        }// end function

        public function hasTarget() : Boolean
        {
            return this.hasTargetRole() || this.targetX != 0 || this.targetY != 0;
        }// end function

        public function get effectRoles() : Array
        {
            return this._effectRoles;
        }// end function

        public function set effectRoles(param1:Array) : void
        {
            this._effectRoles = param1;
            return;
        }// end function

        public function isShapePoint() : Boolean
        {
            return q_area_shape == SHAPE_POINT;
        }// end function

        public function isShapeCircle() : Boolean
        {
            return q_area_shape == SHAPE_CIRCLE;
        }// end function

        public function isUseImmediately() : Boolean
        {
            return this.isShapeCircle() && this.isAreaTargetSelf();
        }// end function

        public function isPointRole() : Boolean
        {
            return q_pointtype == SkillInfo.POINT_TYPE_ROLE;
        }// end function

        public function isAreaTargetSelf() : Boolean
        {
            return q_area_target == AREA_TARGET_SELF;
        }// end function

        public function isTargetFriend() : Boolean
        {
            return q_target == TARGET_TYPE_FRIEND;
        }// end function

        public function isTargetEnemy() : Boolean
        {
            return q_target == TARGET_TYPE_ENEMY;
        }// end function

        public function isTargetSelf() : Boolean
        {
            return q_target == TARGET_TYPE_SELF;
        }// end function

        public function isTargetMouse() : Boolean
        {
            return q_target == TARGET_TYPE_MOUSE;
        }// end function

        public function canUseByJob(param1:Number) : Boolean
        {
            return PropUtil.canUseByJob(q_job, param1);
        }// end function

        public function isElementIce() : Boolean
        {
            return q_skill_elementtype == 0;
        }// end function

        public function isElementThunder() : Boolean
        {
            return q_skill_elementtype == 1;
        }// end function

        public function isElementPoison() : Boolean
        {
            return q_skill_elementtype == 2;
        }// end function

        override public function parse(param1:Object) : void
        {
            super.parse(param1);
            if (q_small_ico && q_small_ico != "0")
            {
                this._iconUrl = Params.SKILL_ICON_PATH + q_small_ico + ".png";
            }
            if (param1.q_passive_buff && param1.q_passive_buff != "")
            {
                this.q_passive_buff = String(param1.q_passive_buff).split(";");
            }
            else
            {
                this.q_passive_buff = [];
            }
            this.updateEffect();
            return;
        }// end function

        public function updateEffect() : void
        {
            if (this.q_use_effect && this.q_use_effect != "0")
            {
                this.releaseURL = Params.SKILL_PATH + this.q_use_effect + ".png";
            }
            if (this.q_trajectory_effect && this.q_trajectory_effect != "0")
            {
                this.flyURL = Params.SKILL_PATH + this.q_trajectory_effect + ".png";
            }
            if (this.q_hit_effect && this.q_hit_effect != "0")
            {
                this.hitURL = Params.SKILL_PATH + this.q_hit_effect + ".png";
            }
            if (this.q_ground_effect && this.q_ground_effect != "0")
            {
                this.releaseGroundURL = Params.SKILL_PATH + this.q_ground_effect + ".png";
            }
            if (this.q_hit_ground_effect && this.q_hit_ground_effect != "0")
            {
                this.hitGroundURL = Params.SKILL_PATH + this.q_hit_ground_effect + ".png";
            }
            return;
        }// end function

        public function testEffect() : void
        {
            if (super.q_use_effect)
            {
                this.releaseURL = Params.SKILL_PATH + super.q_use_effect + ".png";
            }
            if (super.q_hit_effect)
            {
                this.hitURL = Params.SKILL_PATH + super.q_hit_effect + ".png";
            }
            if (super.q_ground_effect)
            {
                this.releaseGroundURL = Params.SKILL_PATH + super.q_ground_effect + ".png";
            }
            if (super.q_hit_ground_effect)
            {
                this.hitGroundURL = Params.SKILL_PATH + super.q_hit_ground_effect + ".png";
            }
            return;
        }// end function

        public function reset() : void
        {
            this.targetX = 0;
            this.targetY = 0;
            this.direct = 0;
            this._effectRoles = [];
            return;
        }// end function

        public function get iconUrl() : String
        {
            var _loc_1:* = MasterSkillData.instance.getMasterSkillBySkillId(q_skillID);
            var _loc_2:* = _loc_1 ? (_loc_1[0]) : (null);
            if (_loc_2 && _loc_2.level && _loc_2.cfg.q_icon_replace)
            {
                return Params.SKILL_ICON_PATH + _loc_2.cfg.q_icon_replace + ".png";
            }
            return this._iconUrl;
        }// end function

        override public function get q_tips() : String
        {
            var _loc_2:* = null;
            var _loc_1:* = MasterSkillData.instance.getMasterSkillEffectBySkillId(q_skillID);
            var _loc_3:* = _loc_1 ? (_loc_1.length) : (0);
            var _loc_4:* = "";
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_2 = _loc_1[_loc_5];
                if (_loc_2 && _loc_2.level)
                {
                    _loc_4 = _loc_4 + _loc_2.cfg.q_desc_replace;
                }
                _loc_5++;
            }
            return super.q_tips + _loc_4;
        }// end function

        override public function get q_use_effect() : String
        {
            var _loc_1:* = this.getEffectByName("q_use_effect");
            if (_loc_1)
            {
                return _loc_1;
            }
            return super.q_use_effect;
        }// end function

        override public function get q_trajectory_effect() : String
        {
            var _loc_1:* = this.getEffectByName("q_trajectory_effect");
            if (_loc_1)
            {
                return _loc_1;
            }
            return super.q_trajectory_effect;
        }// end function

        override public function get q_hit_effect() : String
        {
            var _loc_1:* = this.getEffectByName("q_hit_effect");
            if (_loc_1)
            {
                return _loc_1;
            }
            return super.q_hit_effect;
        }// end function

        override public function get q_ground_effect() : String
        {
            var _loc_1:* = this.getEffectByName("q_ground_effect");
            if (_loc_1)
            {
                return _loc_1;
            }
            return super.q_ground_effect;
        }// end function

        override public function get q_hit_ground_effect() : String
        {
            var _loc_1:* = this.getEffectByName("q_hit_ground_effect");
            if (_loc_1)
            {
                return _loc_1;
            }
            return super.q_hit_ground_effect;
        }// end function

        protected function getEffectByName(param1:String) : String
        {
            var _loc_4:* = null;
            var _loc_2:* = MasterSkillData.instance.getMasterSkillBySkillId(q_skillID);
            var _loc_3:* = _loc_2 ? (_loc_2[0]) : (null);
            if (_loc_3 && _loc_3.level && _loc_3.cfg && _loc_3.cfg.q_effect_replace)
            {
                _loc_4 = _loc_3.cfg.q_effect_replace[param1];
                if (_loc_4)
                {
                    return _loc_4;
                }
            }
            return null;
        }// end function

    }
}
