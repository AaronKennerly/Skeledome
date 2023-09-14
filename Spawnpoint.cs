using Godot;
using System;

public partial class Spawnpoint : Node2D
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		GameManager.spawnpoint = this;
	}
}
