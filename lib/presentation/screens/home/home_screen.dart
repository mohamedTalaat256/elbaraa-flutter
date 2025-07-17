import 'package:elbaraa/data/business_logic/home/home_cubit.dart';
import 'package:elbaraa/data/business_logic/home/home_state.dart';
import 'package:elbaraa/data/models/plan.model.dart';
import 'package:elbaraa/presentation/screens/home/components/appbar.dart';
import 'package:elbaraa/presentation/screens/home/components/instructors.dart';
import 'package:elbaraa/presentation/screens/home/components/materials.dart';
import 'package:elbaraa/presentation/screens/home/components/plan-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../constants/my_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Can\'t connect .. check internet',
              style: TextStyle(fontSize: 22, color: MyColors.myGrey),
            ),
            Image.asset('assets/images/no_internet.png'),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).homeData(); // Only here
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeDataLoaded) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              HomeAppBar(),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: MultiSliver(
                  children: [
                    _buildHeader(),
                    _buildSectionTitle('materials'.i18n()),
                    EducationMaterialList(materials: state.homeData.materials),
                    _buildSectionTitle('best_inscructors'.i18n()),
                    InstructorsList(instructors: state.homeData.instructors),
                    _buildSectionTitle('plans'.i18n()),
                    _buildPlans(state.homeData.plans),
                    _buildSectionTitle("خطة الدورات التدريبية"),
                    _buildCourseCard("دورة 1", "20٪ مكتمل"),
                    _buildCourseCard("دورة 2", "مكتمل"),
                    _buildCourseCard("دورة 3", "قيد التقدم"),
                    _buildSectionTitle("مجالات المنصة"),
                    _buildGridModules(),
                    _buildFooter(),
                  ],
                ),
              ),
            ],
          );
        }
        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://elbaraa.com/backend/public/img/181810_image.jpg',
          ), // replace with your image
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        "منصة البراء",
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }

  Widget _buildPlans(List<Plan> plans) {
    return plans.isEmpty
        ? Text(
            "لا توجد خطط متاحة",
            style: TextStyle(
              fontSize: 20,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return PlanCard(plan: plans[index]);
            }, childCount: plans.length),
          );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCourseCard(String title, String progress) {
    return Card(
      color: Colors.green[800],
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress.contains('%')
                  ? double.parse(progress.replaceAll('%', '')) / 100
                  : 0.5,
              color: Colors.amber,
              backgroundColor: Colors.white24,
            ),
            SizedBox(height: 8),
            Text(progress, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildGridModules() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(4, (index) {
          return Card(
            elevation: 3,
            child: Center(
              child: ListTile(
                title: Icon(Icons.school, size: 40, color: Colors.green),
                subtitle: Text("قسم ${index + 1}", textAlign: TextAlign.center),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Text(
            "منصة البراء",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            "جميع الحقوق محفوظة © 2025",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
