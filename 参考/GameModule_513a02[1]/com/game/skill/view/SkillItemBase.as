package com.game.skill.view
{
    import com.f1.interfaces.ui.list.*;
    import com.game.team.view.*;

    public class SkillItemBase extends ListItemBase implements IItem
    {

        public function SkillItemBase(param1:String)
        {
            super(param1);
            return;
        }// end function

        public function get key()
        {
            return null;
        }// end function

        public function get obj()
        {
            return null;
        }// end function

        public function set obj(param1) : void
        {
            return;
        }// end function

        public function get label() : String
        {
            return null;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

    }
}
