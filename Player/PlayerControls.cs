using Godot;
using System;

[GlobalClass]
public partial class PlayerControls : Resource
{
	[Export]
	public int playerIndex { get; set; }

	[Export]
	public string moveLeft { get; set; }

	[Export]
	public string moveRight { get; set; }

	[Export]
	public string jump { get; set; }
		
	public PlayerControls() : this(0, "move_left1", "move_right1", "jump1") {}
		
	public PlayerControls(int player, string left, string right, string up)
	{
		playerIndex = player;
		moveLeft = left;
		moveRight = right;
		jump = up;
	}
}
