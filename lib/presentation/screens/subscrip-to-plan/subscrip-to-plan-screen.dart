import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/data/business_logic/instructor/instructor_cubit.dart';
import 'package:elbaraa/data/business_logic/instructor/instructor_state.dart';
import 'package:elbaraa/data/business_logic/plan/plan_cubit.dart';
import 'package:elbaraa/data/business_logic/plan/plan_state.dart';
import 'package:elbaraa/data/models/UnavalableTimeDataSource.dart';
import 'package:elbaraa/data/models/instructor.model.dart';
import 'package:elbaraa/data/models/material.model.dart';
import 'package:elbaraa/data/models/meeting.model.dart';
import 'package:elbaraa/data/models/plan.model.dart';
import 'package:elbaraa/data/models/unavailableTime.model.dart';
import 'package:elbaraa/presentation/widgets/custome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:localization/localization.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
  late List<Meeting> events = [];
  late List<Appointment> unavailableTimes = [];
  Set<int> selectedMaterial = {};
  Set<int> selectedInstructor = {};
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlanCubit>(context).findById(widget.planId);
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
                Step(
                  title: Text('sessions'.i18n()),
                  content:  SizedBox(
        height: MediaQuery.of(context).size.height * 0.72, child :SfCalendar(
                    view: CalendarView.week,
                    headerStyle: CalendarHeaderStyle(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                    dataSource: UnavalableTimeDataSource(unavailableTimes),
                    monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment,
                    ),
                    onTap: (CalendarTapDetails details) {
                      /*  if (details.targetElement ==
                          CalendarElement.calendarCell) {
                        final DateTime selectedDate = details.date!;
                        _showAddEventDialog(context, selectedDate);
                      } */
                    },
                  )),
                ),
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
                                          print(
                                            instructor
                                                .unavailableTimes
                                                .first
                                                .day,
                                          );
                                          unavailableTimes = modifyListTimesAfterChangeTimeZoneUnavailableTimes(instructor.unavailableTimes);
                                          
                                          /*  BlocProvider.of<InstructorCubit>(
                                            context,
                                          ).getActiveInstructorByMaterialI(
                                            selectedMaterial.first,
                                          ); */
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

  List<Appointment> modifyListTimesAfterChangeTimeZoneUnavailableTimes(
    List<UnavailableTime> list,
  ) {
    return list.map((event) {
      final DateTime localStart = event.start.toLocal();
      final DateTime localEnd = event.end.toLocal();
      final String weekday = event.day
          .substring(0, 2)
          .toUpperCase();
          
      final String formattedStart = Jiffy.parseFromDateTime(localStart)
      .format(pattern: "yyyyMMdd'T'HHmmss");
      return Appointment(
        id: event.id,
        subject: event.id.toString(),
        color: Colors.red,
        startTime: localStart,
        endTime: localEnd,
        notes: 'Discuss quarterly earnings',
        recurrenceRule: 'FREQ=WEEKLY;BYDAY=$weekday;DTSTART=$formattedStart',
      );
    }).toList();
  }
}
