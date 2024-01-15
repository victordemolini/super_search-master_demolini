import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // NOTES:
  // - normally we'd use something like flutter_dotenv package vs hardcoding
  //   these values here.
  await Supabase.initialize(
      url: 'https://zxbwsumjmrgagakwtial.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp4YndzdW1qbXJnYWdha3d0aWFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDUwNzQ2MTAsImV4cCI6MjAyMDY1MDYxMH0.5V-HSe-XVS-nI0r3Zdo7FaEmrtfLqLX8SIb-gWtD3II',
      debug: true);

  runApp(const App());
}
