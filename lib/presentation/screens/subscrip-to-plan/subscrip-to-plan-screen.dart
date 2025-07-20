import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/data/business_logic/instructor/instructor_cubit.dart';
import 'package:elbaraa/data/business_logic/instructor/instructor_state.dart';
import 'package:elbaraa/data/business_logic/plan/plan_cubit.dart';
import 'package:elbaraa/data/business_logic/plan/plan_state.dart';
import 'package:elbaraa/data/business_logic/session/session_cubit.dart';
import 'package:elbaraa/data/business_logic/session/session_state.dart';
import 'package:elbaraa/data/models/instructor.model.dart';
import 'package:elbaraa/data/models/material.model.dart';
import 'package:elbaraa/data/models/meeting.model.dart';
import 'package:elbaraa/data/models/plan.model.dart';
import 'package:elbaraa/data/models/session.model.dart';
import 'package:elbaraa/data/models/unavailableTime.model.dart';
import 'package:elbaraa/presentation/screens/subscrip-to-plan/supscrip-calendar.dart';
import 'package:elbaraa/presentation/widgets/custome_text.dart';
import 'package:elbaraa/utils/Calendar.utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

class SupscripToPlanScreen extends StatefulWidget {
  final int planId;

  const SupscripToPlanScreen({super.key, required this.planId});

  @override
  State<SupscripToPlanScreen> createState() => _SupscripToPlanScreenState();
}

class _SupscripToPlanScreenState extends State<SupscripToPlanScreen> {
  late Plan plan;
  late List<MaterialModel> materials = [];
  late List<Instructor> instructors = [];
  late List<Session> studentSessions = [];
  late List<Meeting> events = [];
  late List<UnavailableTime> unavailableTimes = [];
  late List<Session> instructorSessions = [];
  Set<int> selectedMaterial = {};
  Set<int> selectedInstructor = {};
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlanCubit>(context).findById(widget.planId);
    BlocProvider.of<SessionCubit>(context).getUserCalendar();
  }

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanCubit, PlanState>(
      builder: (context, state) {
        if (state is PlanWithMaterialsLoaded) {
          plan = state.plan;
          materials = state.materials;

          final visibleMaterials = selectedMaterial.isEmpty
              ? materials
              : materials
                    .where((m) => selectedMaterial.contains(m.id))
                    .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('${'subscrip_in'.i18n()} ${plan.title}'),
            ),
            body: Stepper(
              type: StepperType.horizontal,
              elevation: 0,
              currentStep: _index,
              onStepCancel: () {
                if (_index > 0) {
                  setState(() {
                    _index -= 1;
                  });
                }
              },
              onStepContinue: () {
                if (_index <= 0) {
                  setState(() {
                    _index += 1;
                  });
                }
              },
              onStepTapped: (int index) {
                setState(() {
                  _index = index;
                });
              },
              steps: <Step>[
                _buildFirstStep(context, visibleMaterials),
                _buildSecondStep(context),
                _buildCalendarStep(context),
                Step(
                  title: Text('save'.i18n()),
                  content: Text('Content for Step 2'),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(body: Center(child: Text('loading')));
        }
      },
    );
  }

  Step _buildCalendarStep(BuildContext context) {
    return Step(
      title: Text('sessions'.i18n()),
      content: BlocBuilder<SessionCubit, SessionState>(
        builder: (context, state) {
          if (state is SessionsLoaded) {
            studentSessions = state.sessions;
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.72,
              child: SubscripCalendar(calendarEvents: mergeAllEventsNew(
                    studentSessions,
                    instructorSessions,
                    unavailableTimes,
                  ))
            );
          } else {
            return Text("loading");
          }
        },
      ),
    );
  }

  Step _buildSecondStep(BuildContext context) {
    return Step(
      title: Text('the_instructor'.i18n()),
      content: BlocBuilder<InstructorCubit, InstructorState>(
        builder: (context, state) {
          if (state is InstructorsByMaterialLoaded) {
            instructors = state.instructors;

            final visibleInstructors = selectedInstructor.isEmpty
                ? instructors
                : instructors
                      .where((i) => selectedInstructor.contains(i.id))
                      .toList();
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.72,
              child: ListView.builder(
                itemCount: visibleInstructors.length,
                itemBuilder: (context, index) {
                  final instructor = visibleInstructors[index];
                  final originalInstructorIndex = instructor.id;
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: defaultBorderColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Checkbox(
                                    value: selectedInstructor.contains(
                                      originalInstructorIndex,
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value == true) {
                                          selectedInstructor.add(
                                            originalInstructorIndex,
                                          );
                                        } else {
                                          selectedInstructor.remove(
                                            originalInstructorIndex,
                                          );
                                        }
                                        if (selectedInstructor.isNotEmpty) {
                                          unavailableTimes =
                                              instructor.unavailableTimes;
                                          instructorSessions =
                                              instructor.sessions;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    instructors[index].imageUrl,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    CustomeText(
                                      text: instructors[index].firstName,
                                      alignment: TextAlign.start,
                                    ),
                                    CustomeText(
                                      text: instructors[index].country,
                                      alignment: TextAlign.start,
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Text("");
          }
        },
      ),
    );
  }

  Step _buildFirstStep(
    BuildContext context,
    List<MaterialModel> visibleMaterials,
  ) {
    return Step(
      title: Text('the_material'.i18n()),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.72,
        child: ListView.builder(
          itemCount: visibleMaterials.length,
          itemBuilder: (context, index) {
            final material = visibleMaterials[index];
            final originalIndex = material.id;

            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: defaultBorderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: selectedMaterial.contains(originalIndex),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedMaterial.add(originalIndex);
                              } else {
                                selectedMaterial.remove(originalIndex);
                              }
                              if (selectedMaterial.isNotEmpty) {
                                BlocProvider.of<InstructorCubit>(
                                  context,
                                ).getActiveInstructorByMaterialI(
                                  selectedMaterial.first,
                                );
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        height: 60,
                        width: 60,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading.gif',
                          image: '$imagesUrls/${material.image}',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          material.title,
                          style: const TextStyle(color: Color(0xFF000000)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
